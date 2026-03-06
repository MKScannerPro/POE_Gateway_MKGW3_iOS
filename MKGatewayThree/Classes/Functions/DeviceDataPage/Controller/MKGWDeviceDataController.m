//
//  MKGWDeviceDataController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWDeviceDataController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSDictionary+MKAdd.h"

#import "MKHudManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKScannerDeviceModelManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWDeviceDataPageHeaderView.h"
#import "MKGWDeviceDataPageCell.h"
#import "MKGWFilterTestAlert.h"
#import "MKGWFilterTestResultAlert.h"

#import "MKGWSettingController.h"
#import "MKGWSettingForV2Controller.h"

#import "MKGWUploadOptionController.h"
#import "MKGWUploadOptionV2Controller.h"
#import "MKGWManageBleDevicesController.h"
#import "MKGWManageBleDevicesV2Controller.h"
#import "MKGWBleDevicesPageAdopter.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKGWDeviceDataController ()<UITableViewDelegate,
UITableViewDataSource,
MKGWDeviceDataPageHeaderViewDelegate,
MKGWReceiveDeviceDatasDelegate>

@property (nonatomic, strong)MKGWDeviceDataPageHeaderView *headerView;

@property (nonatomic, strong)MKGWDeviceDataPageHeaderViewModel *headerModel;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@property (nonatomic, strong)dispatch_source_t filterTimer;

@property (nonatomic, assign)NSInteger filterTime;

@property (nonatomic, assign)NSInteger totalAlarmStatus;

@end

@implementation MKGWDeviceDataController

- (void)dealloc {
    NSLog(@"MKGWDeviceDataController销毁");
    [MKScannerDeviceModelManager sharedDealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
    if (self.filterTimer) {
        dispatch_cancel(self.filterTimer);
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MKGWMQTTDataManager shared].dataDelegate = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
    if (self.headerModel.isOn) {
        [MKGWMQTTDataManager shared].dataDelegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
    [self runloopObserver];
    [self addNotifications];
}

#pragma mark - super method
- (void)rightButtonMethod {
    if ([MKScannerDeviceModelManager shared].isV2) {
        MKGWSettingForV2Controller *vc = [[MKGWSettingForV2Controller alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    MKGWSettingController *vc = [[MKGWSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGWDeviceDataPageCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGWDeviceDataPageCell *cell = [MKGWDeviceDataPageCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - MKGWDeviceDataPageHeaderViewDelegate

- (void)gw_updateLoadButtonAction {
    if ([MKScannerDeviceModelManager shared].isV2) {
        MKGWUploadOptionV2Controller *vc = [[MKGWUploadOptionV2Controller alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    MKGWUploadOptionController *vc = [[MKGWUploadOptionController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gw_scannerStatusChanged:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_configScanSwitchStatus:isOn
                                      macAddress:[MKScannerDeviceModelManager shared].macAddress
                                           topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                        sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = isOn;
        [self updateStatus];
    }
                                     failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gw_manageBleDeviceAction {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_readGatewayBleConnectStatusWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        NSArray *deviceList = returnData[@"data"][@"ble_conn_list"];
        if (ValidArray(deviceList)) {
            //网关已经连接设备
            NSDictionary *connectDevice = deviceList[0];
            [self readConnectedDeviceInfoWithBleMac:connectDevice[@"mac"] type:[connectDevice[@"type"] integerValue]];
            return;
        }
        //网关没有连接设备
        if ([MKScannerDeviceModelManager shared].isV2) {
            MKGWManageBleDevicesV2Controller *vc = [[MKGWManageBleDevicesV2Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        MKGWManageBleDevicesController *vc = [[MKGWManageBleDevicesController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
                                                        failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)gw_filterTestButtonAction {
    MKGWFilterTestAlert *alertView = [[MKGWFilterTestAlert alloc] init];
    [alertView showWithHandler:^(NSString * duration) {
        if (!ValidStr(duration)) {
            [self.view showCentralToast:@"The duration cannot be empty"];
            return;
        }
        self.filterTime = [duration integerValue];
        [self operatefilterTimer];
    }];
}

#pragma mark - MKGWReceiveDeviceDatasDelegate
- (void)mk_gw_receiveDeviceDatas:(NSDictionary *)data {
    if (!ValidDict(data) || !ValidStr(data[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:data[@"device_info"][@"mac"]]) {
        return;
    }
    NSArray *tempList = data[@"data"];
    if (!ValidArray(tempList)) {
        return;
    }
    for (NSDictionary *dic in tempList) {
        NSString *jsonString = [self convertToJsonData:dic];
        if (ValidStr(jsonString)) {
            self.totalAlarmStatus ++;
            MKGWDeviceDataPageCellModel *cellModel = [[MKGWDeviceDataPageCellModel alloc] init];
            cellModel.msg = jsonString;
            if (self.dataList.count == 0) {
                [self.dataList addObject:cellModel];
            }else {
                [self.dataList insertObject:cellModel atIndex:0];
            }
        }
    }
    [self needRefreshList];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if(!policyData && error){
        return @"";
    }
    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return policyStr;
}


- (void)receiveDeviceNameChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"macAddress"]]) {
        return;
    }
    self.defaultTitle = user[@"deviceName"];
}

- (void)deviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"macAddress"]];
}

- (void)receiveDeviceLwtMessage:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

- (void)deviceResetByButton:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_readScanSwitchStatusWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = ([returnData[@"data"][@"scan_switch"] integerValue] == 1);
        self.headerView.dataModel = self.headerModel;
        [self updateStatus];
    }
                                                 failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac type:(NSInteger)type {
    MKGWManageBleDevicesType devicesType = MKGWManageBleDevicesTypeBXPBD;
    if (type == 0) {
        //通用链接
        devicesType = MKGWManageBleDevicesTypeOther;
    } else if (type == 1) {
        //BXP-B-D
        devicesType = MKGWManageBleDevicesTypeBXPBD;
    } else if (type == 2) {
        //BXP-B-CR
        devicesType = MKGWManageBleDevicesTypeBXPBCR;
    } else if (type == 3) {
        //BXP-C
        devicesType = MKGWManageBleDevicesTypeBXPC;
    } else if (type == 4) {
        //BXP-D
        devicesType = MKGWManageBleDevicesTypeBXPD;
    } else if (type == 5) {
        //BXP-T
        devicesType = MKGWManageBleDevicesTypeBXPT;
    } else if (type == 6) {
        //BXP-S
        devicesType = MKGWManageBleDevicesTypeBXPS;
    } else if (type == 7) {
        //MK Pir
        devicesType = MKGWManageBleDevicesTypePIR;
    } else if (type == 8) {
        //MK Tof
        devicesType = MKGWManageBleDevicesTypeTOF;
    }
    [MKGWBleDevicesPageAdopter readConnectedDeviceInfoWithBleMac:bleMac
                                                            type:devicesType
                                                        sucBlock:^{
        [[MKHudManager share] hide];
        [self pusPageWithType:devicesType];
    }
                                                     failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)pusPageWithType:(MKGWManageBleDevicesType)type {
    UIViewController *vc = [MKGWBleDevicesPageAdopter loadBXPBDPage];
    if (type == MKGWManageBleDevicesTypeBXPBCR) {
        vc = [MKGWBleDevicesPageAdopter loadBXPBCRPage];
    } else if (type == MKGWManageBleDevicesTypeBXPC) {
        vc = [MKGWBleDevicesPageAdopter loadBXPCPage];
    } else if (type == MKGWManageBleDevicesTypeBXPD) {
        vc = [MKGWBleDevicesPageAdopter loadBXPDPage];
    } else if (type == MKGWManageBleDevicesTypeBXPT) {
        vc = [MKGWBleDevicesPageAdopter loadBXPTPage];
    } else if (type == MKGWManageBleDevicesTypeBXPS) {
        vc = [MKGWBleDevicesPageAdopter loadBXPSPage];
    } else if (type == MKGWManageBleDevicesTypePIR) {
        vc = [MKGWBleDevicesPageAdopter loadMKPirPage];
    } else if (type == MKGWManageBleDevicesTypeTOF) {
        vc = [MKGWBleDevicesPageAdopter loadMKTofPage];
    } else if (type == MKGWManageBleDevicesTypeOther) {
        vc = [MKGWBleDevicesPageAdopter loadNormalConnectedPage];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private method

/// 当扫描状态发生改变的时候，需要动态刷新UI，如果打开则添加扫描数据监听，如果关闭，则移除扫描数据监听
- (void)updateStatus {
    [self.dataList removeAllObjects];
    [self.headerView setDataModel:self.headerModel];
    [self.headerView updateTotalNumbers:0];
    [self.tableView reloadData];
    if (self.headerModel.isOn) {
        //打开
        [MKGWMQTTDataManager shared].dataDelegate = self;
        return;
    }
    //关闭状态
    [MKGWMQTTDataManager shared].dataDelegate = nil;
}

- (void)operatefilterTimer {
    if (self.filterTimer) {
        dispatch_cancel(self.filterTimer);
    }
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    self.totalAlarmStatus = 0;
    self.filterTimer = nil;
    self.filterTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.filterTimer, dispatch_time(DISPATCH_TIME_NOW, self.filterTime * NSEC_PER_SEC), DISPATCH_TIME_FOREVER, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.filterTimer, ^{
        @strongify(self);
        dispatch_cancel(self.filterTimer);
        moko_dispatch_main_safe((^{
            [[MKHudManager share] hide];
            self.filterTime = 0;
            MKGWFilterTestResultAlert *alertView = [[MKGWFilterTestResultAlert alloc] init];
            [alertView show:self.totalAlarmStatus];
        }));
    });
    dispatch_resume(self.filterTimer);
}

#pragma mark - 定时刷新

- (void)needRefreshList {
    //标记需要刷新
    self.isNeedRefresh = YES;
    //唤醒runloop
    CFRunLoopWakeUp(CFRunLoopGetMain());
}

- (void)runloopObserver {
    @weakify(self);
    __block NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    self.observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        @strongify(self);
        if (activity == kCFRunLoopBeforeWaiting) {
            //runloop空闲的时候刷新需要处理的列表,但是需要控制刷新频率
            NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
            if (currentInterval - timeInterval < kRefreshInterval) {
                return;
            }
            timeInterval = currentInterval;
            if (self.isNeedRefresh) {
                [self.tableView reloadData];
                self.headerView.dataModel = self.headerModel;
                [self.headerView updateTotalNumbers:self.dataList.count];
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceNameChanged:)
                                                 name:@"mk_gw_deviceNameChangedNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOffline:)
                                                 name:MKScannerDeviceModelOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceLwtMessage:)
                                                 name:MKGWReceiveDeviceOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceResetByButton:)
                                                 name:MKGWReceiveDeviceResetByButtonNotification
                                               object:nil];
}

- (void)processOfflineWithMacAddress:(NSString *)macAddress {
    if (![macAddress isEqualToString:[MKScannerDeviceModelManager shared].macAddress]) {
        return;
    }
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_scanner_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    if ([MKBaseViewController isCurrentViewControllerVisible:self]) {
        [self.view showCentralToast:@"device is off-line"];
    }
    [self performSelector:@selector(gobackToDeviceListView) withObject:nil afterDelay:0.5f];
}

- (void)gobackToDeviceListView {
    [self popToViewControllerWithClassName:@"MKGWDeviceListController"];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKScannerDeviceModelManager shared].deviceName;
    [self.rightButton setImage:LOADICON(@"MKGatewayThree", @"MKGWDeviceDataController", @"gw_moreIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MKGWDeviceDataPageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKGWDeviceDataPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 200.f)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (MKGWDeviceDataPageHeaderViewModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [[MKGWDeviceDataPageHeaderViewModel alloc] init];
    }
    return _headerModel;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
