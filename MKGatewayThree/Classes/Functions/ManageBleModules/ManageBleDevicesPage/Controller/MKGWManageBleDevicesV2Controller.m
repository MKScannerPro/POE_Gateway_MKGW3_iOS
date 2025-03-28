//
//  MKGWManageBleDevicesV2Controller.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWManageBleDevicesV2Controller.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSDictionary+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"
#import "MKAlertView.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWNormalConnectedController.h"
#import "MKGWBXPButtonController.h"
#import "MKGWBXPButtonCRController.h"
#import "MKGWBXPCController.h"
#import "MKGWBXPDController.h"
#import "MKGWBXPTController.h"
#import "MKGWBXPSController.h"
#import "MKGWPirController.h"
#import "MKGWTofController.h"

#import "MKGWManageBleDeviceSearchView.h"
#import "MKGWManageBleDevicesSearchButton.h"
#import "MKGWManageBleDevicesCell.h"
#import "MKGWManageBleDevicesTypeSelectedView.h"

static CGFloat const offset_X = 15.f;
static CGFloat const searchButtonHeight = 40.f;
static CGFloat const headerViewHeight = 90.f;

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKGWManageBleDevicesV2Controller ()<UITableViewDelegate,
UITableViewDataSource,
MKGWManageBleDevicesSearchButtonDelegate,
MKGWManageBleDevicesCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)MKGWManageBleDevicesSearchButtonModel *buttonModel;

@property (nonatomic, strong)MKGWManageBleDevicesSearchButton *searchButton;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@property (nonatomic, strong)NSMutableDictionary *dataCache;

@property (nonatomic, copy)NSString *asciiText;

@end

@implementation MKGWManageBleDevicesV2Controller

- (void)dealloc {
    NSLog(@"MKGWManageBleDevicesV2Controller销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self runloopObserver];
    [self addNotes];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGWManageBleDevicesCell *cell = [MKGWManageBleDevicesCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKGWManageBleDevicesSearchButtonDelegate
- (void)gw_scanSearchButtonMethod {
    [MKGWManageBleDeviceSearchView showSearchName:self.buttonModel.searchName
                                       macAddress:self.buttonModel.searchMac
                                             rssi:self.buttonModel.searchRssi
                                      searchBlock:^(NSString * _Nonnull searchName, NSString * _Nonnull searchMacAddress, NSInteger searchRssi) {
        self.buttonModel.searchRssi = searchRssi;
        self.buttonModel.searchName = searchName;
        self.buttonModel.searchMac = searchMacAddress;
        self.searchButton.dataModel = self.buttonModel;
        
        [self.dataList removeAllObjects];
        [self.dataCache removeAllObjects];
        [self.tableView reloadData];
    }];
}

- (void)gw_scanSearchButtonClearMethod {
    self.buttonModel.searchRssi = -127;
    self.buttonModel.searchMac = @"";
    self.buttonModel.searchName = @"";
    
    [self.dataList removeAllObjects];
    [self.dataCache removeAllObjects];
    [self.tableView reloadData];
}


#pragma mark - MKGWManageBleDevicesCellDelegate
/// 用户点击了链接按钮
/// @param macAddress 目标设备的mac地址
/// @param typeCode 目标设备的设备类型
/*
 typeCode:
 0：ibeacon
 1：eddystone-uid
 2：eddystone-url
 3：eddystone-tlm
 4：bxp-devinfo
 5：bxp-acc
 6：bxp-th
 7：bxp-button
 8：bxp-tag
 9：pir
 10：other
 */
- (void)gw_manageBleDevicesCellConnectButtonPressed:(NSString *)macAddress typeCode:(NSInteger)typeCode {
    
    NSString *recordSelectedType = [[NSUserDefaults standardUserDefaults] objectForKey:@"gw_bleDeviceConnectType"];
    if (!ValidStr(recordSelectedType)) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"gw_bleDeviceConnectType"];
        recordSelectedType = @"1";
    }
    
    [MKGWManageBleDevicesTypeSelectedView showWithType:[recordSelectedType integerValue] selecteBlock:^(MKGWManageBleDevicesTypeSelectedViewType selectedType) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)selectedType] forKey:@"gw_bleDeviceConnectType"];
        [self connectDeviceWithMacAddress:macAddress selectedType:selectedType];
    }];
}

#pragma mark - note
- (void)receiveDeviceDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKGWDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSArray *tempList = user[@"data"];
    if (!ValidArray(tempList)) {
        return;
    }
    for (NSDictionary *dic in tempList) {
        [self processReceiveData:dic];
    }
    [self needRefreshList];
}

#pragma mark - private method
- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceDatas:)
                                                 name:MKGWReceiveDeviceDatasNotification
                                               object:nil];
}

- (void)processReceiveData:(NSDictionary *)dic {
    if (!ValidDict(dic)) {
        return;
    }
    NSInteger rssi = [dic[@"rssi"] integerValue];
    NSString *deviceName = dic[@"adv_name"];
    NSString *macAddress = dic[@"mac"];
    if (ValidStr(self.buttonModel.searchMac) || ValidStr(self.buttonModel.searchName)) {
        //如果打开了过滤，先看是否需要过滤设备名字和mac地址
        if (rssi >= self.buttonModel.searchRssi) {
            //开启了过滤则必然要判断rssi
            if ([[deviceName uppercaseString] containsString:[self.buttonModel.searchName uppercaseString]]
                || [[[macAddress stringByReplacingOccurrencesOfString:@":" withString:@""] uppercaseString] containsString:[self.buttonModel.searchMac uppercaseString]]) {
                //符合要求
                [self updateCellModelWithMac:macAddress
                                 connentable:[dic[@"connectable"] boolValue]
                                    typeCode:[dic[@"type_code"] integerValue]
                                        rssi:rssi
                                  deviceName:deviceName];
                return;
            }
            return;
        }
        return;
    }
    if (self.buttonModel.searchRssi > self.buttonModel.minSearchRssi) {
        //仅开启rssi过滤
        if (rssi >= self.buttonModel.searchRssi) {
            //符合要求
            [self updateCellModelWithMac:macAddress
                             connentable:[dic[@"connectable"] boolValue]
                                typeCode:[dic[@"type_code"] integerValue]
                                    rssi:rssi
                              deviceName:deviceName];
            return;
        }
        return;
    }
    //无过滤条件
    [self updateCellModelWithMac:macAddress
                     connentable:[dic[@"connectable"] boolValue]
                        typeCode:[dic[@"type_code"] integerValue]
                            rssi:rssi
                      deviceName:deviceName];
}

- (void)updateCellModelWithMac:(NSString *)macAddress
                   connentable:(BOOL)connentable
                      typeCode:(NSInteger)typeCode
                          rssi:(NSInteger)rssi
                    deviceName:(NSString *)deviceName{
    MKGWManageBleDevicesCellModel *cellModel = [[MKGWManageBleDevicesCellModel alloc] init];
    cellModel.macAddress = macAddress;
    cellModel.connectable = connentable;
    cellModel.deviceName = deviceName;
    cellModel.rssi = rssi;
    cellModel.typeCode = typeCode;
    NSNumber *indexValue = self.dataCache[macAddress];
    if (ValidNum(indexValue)) {
        //当前数据源中已经包含该数据，则替换
        [self.dataList replaceObjectAtIndex:[indexValue integerValue] withObject:cellModel];
    }else {
        //不存在，添加
        [self.dataCache setObject:@(self.dataList.count) forKey:macAddress];
        [self.dataList addObject:cellModel];
    }
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
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

#pragma mark - 连接部分
- (void)connectDeviceWithMacAddress:(NSString *)macAddress
                       selectedType:(MKGWManageBleDevicesTypeSelectedViewType)selectedType {
    if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeOther) {
        [self connectNormalDeviceWithBleMac:macAddress];
        return;
    }
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
        @strongify(self);
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeBXPBD) {
                //BXP-B-D
                [self connectBXPButtonWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeBXPBCR) {
                //BXP-B-CR
                [self connectBXPButtonCRWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeBXPC) {
                //BXP-C
                [self connectBXPCWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeBXPD) {
                //BXP-D
                [self connectBXPDWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeBXPT) {
                //BXP-T
                [self connectBXPTWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeBXPS) {
                //BXP-S
                [self connectBXPSWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypePIR) {
                //MK Pir
                [self connectMKPirWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
            if (selectedType == MKGWManageBleDevicesTypeSelectedViewTypeTOF) {
                //MK Tof
                [self connectMKTofWithPassword:self.asciiText bleMac:macAddress];
                return;
            }
        });
    }];
    MKAlertViewTextField *textField = [[MKAlertViewTextField alloc] initWithTextValue:@""
                                                                          placeholder:@"Password is 0-16 Chracters"
                                                                        textFieldType:mk_normal
                                                                            maxLength:16
                                                                              handler:^(NSString * _Nonnull text) {
        @strongify(self);
        self.asciiText = text;
    }];
    
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView addTextField:textField];
    [alertView showAlertWithTitle:@"Enter password" message:@"" notificationName:@"mk_gw_needDismissAlert"];
}

- (void)connectBXPButtonWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectBXPButtonWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWBXPButtonController *vc = [[MKGWBXPButtonController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectBXPButtonCRWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectBXPButtonCRWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWBXPButtonCRController *vc = [[MKGWBXPButtonCRController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectBXPCWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectBXPCWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWBXPCController *vc = [[MKGWBXPCController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectBXPDWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectBXPDWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWBXPDController *vc = [[MKGWBXPDController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectBXPTWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectBXPTWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWBXPTController *vc = [[MKGWBXPTController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectBXPSWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectBXPSWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWBXPSController *vc = [[MKGWBXPSController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectMKPirWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectMKPirWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWPirController *vc = [[MKGWPirController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectMKTofWithPassword:(NSString *)password bleMac:(NSString *)bleMac {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectMKTofWithPassword:password bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWTofController *vc = [[MKGWTofController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)connectNormalDeviceWithBleMac:(NSString *)macAddress {
    [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_connectNormalBleDeviceWithBleMac:macAddress macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            [self.view showCentralToast:returnData[@"data"][@"result_msg"]];
            return;
        }
        MKGWNormalConnectedController *vc = [[MKGWNormalConnectedController alloc] init];
        vc.deviceBleInfo = returnData;
        [self.navigationController pushViewController:vc animated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKGWDeviceModeManager shared].deviceName;
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = RGBCOLOR(237, 243, 250);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.height.mas_equalTo(searchButtonHeight + 2 * 15.f);
    }];
    [topView addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(searchButtonHeight);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0.f);
        make.right.mas_equalTo(0.f);
        make.top.mas_equalTo(topView.mas_bottom);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-5.f);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (MKGWManageBleDevicesSearchButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [[MKGWManageBleDevicesSearchButton alloc] init];
        _searchButton.delegate = self;
    }
    return _searchButton;
}

- (MKGWManageBleDevicesSearchButtonModel *)buttonModel {
    if (!_buttonModel) {
        _buttonModel = [[MKGWManageBleDevicesSearchButtonModel alloc] init];
        _buttonModel.placeholder = @"Edit Filter";
        _buttonModel.minSearchRssi = -127;
        _buttonModel.searchRssi = -127;
    }
    return _buttonModel;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableDictionary *)dataCache {
    if (!_dataCache) {
        _dataCache = [NSMutableDictionary dictionary];
    }
    return _dataCache;
}

@end
