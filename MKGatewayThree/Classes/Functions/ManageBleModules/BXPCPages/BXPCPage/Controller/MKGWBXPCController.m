//
//  MKGWBXPCController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/10.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPCController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertView.h"
#import "MKSettingTextCell.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWButtonFirmwareCell.h"

#import "MKGWButtonDFUController.h"
#import "MKGWBXPCRealTimeTHDataController.h"
#import "MKGWBXPCHistoricalTHDataController.h"
#import "MKGWBXPCAccelerometerController.h"
#import "MKGWBXPCTHDataSampleRateController.h"
#import "MKGWBXPCAdvParamsController.h"

@interface MKGWBXPCController ()<UITableViewDelegate,
UITableViewDataSource,
MKGWButtonFirmwareCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)NSDictionary *bxpStatusDic;

@end

@implementation MKGWBXPCController

- (void)dealloc {
    NSLog(@"MKGWBXPCController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //本页面禁止右划退出手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self addNotes];
    [self loadSectionDatas];
    [self readDatasFromDevice];
}

#pragma mark - super method

- (void)rightButtonMethod {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
        
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self disconnect];
    }];
    NSString *msg = @"Please confirm agian whether to disconnect the gateway from BLE devices?";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"" message:msg notificationName:@"mk_gw_needDismissAlert"];
}

- (void)leftButtonMethod {
    //用户点击左上角，则需要返回MKGWDeviceDataController
    [self popToViewControllerWithClassName:@"MKGWDeviceDataController"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 10.f;
    }
    
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 && indexPath.row == 0) {
        //Real time T&H data
        MKGWBXPCRealTimeTHDataController *vc = [[MKGWBXPCRealTimeTHDataController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        //Historical T&H data
        MKGWBXPCHistoricalTHDataController *vc = [[MKGWBXPCHistoricalTHDataController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 2) {
        //Accelerometer data
        MKGWBXPCAccelerometerController *vc = [[MKGWBXPCAccelerometerController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 3) {
        //T&H data sample rate
        MKGWBXPCTHDataSampleRateController *vc = [[MKGWBXPCTHDataSampleRateController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 4) {
        //Advertisement parameters
        MKGWBXPCAdvParamsController *vc = [[MKGWBXPCAdvParamsController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (indexPath.section == 3 && indexPath.row == 5) {
        //Power off
        [self powerOff];
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKGWButtonFirmwareCell *cell = [MKGWButtonFirmwareCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section2List[indexPath.row];
        return cell;
    }
    MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
    cell.dataModel =  self.section3List[indexPath.row];
    return cell;
}

#pragma mark - MKGWButtonFirmwareCellDelegate
- (void)gw_buttonFirmwareCell_buttonAction:(NSInteger)index {
    if (index == 0) {
        //DFU
        MKGWButtonDFUController *vc = [[MKGWButtonDFUController alloc] init];
        vc.bleMacAddress = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKGWDeviceModeManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.deviceBleInfo[@"data"][@"mac"]]) {
        return;
    }
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_gw_needDismissAlert" object:nil];
    //返回上一级页面
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_readBXPCConnectedStatusWithBleMacAddress:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            [self.view showCentralToast:@"Read Failed"];
            return;
        }
        self.bxpStatusDic = returnData;
        [self updateStatusDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)disconnect {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_disconnectNormalBleDeviceWithBleMac:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)powerOffCmdToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_bxpBXPCPowerOffWithBleMac:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateStatusDatas {
    MKNormalTextCellModel *cellModel1 = self.section2List[3];
    cellModel1.rightMsg = [NSString stringWithFormat:@"%@%@",self.bxpStatusDic[@"data"][@"battery_v"],@"mV"];
    
    [self.tableView reloadData];
}

#pragma mark - private method
- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGWReceiveGatewayDisconnectBXPButtonNotification
                                               object:nil];
}

- (void)powerOff {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"OK" handler:^{
        @strongify(self);
        [self powerOffCmdToDevice];
    }];
    
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@""
                          message:@"Please confirm again whether to power off BLE device"
                 notificationName:@"mk_gw_needDismissAlert"];
    return;
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    
    for (NSInteger i = 0; i < 4; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Product model";
    cellModel1.rightMsg = SafeStr(self.deviceBleInfo[@"data"][@"product_model"]);
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Manufacture";
    cellModel2.rightMsg = SafeStr(self.deviceBleInfo[@"data"][@"company_name"]);
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKGWButtonFirmwareCellModel *cellModel = [[MKGWButtonFirmwareCellModel alloc] init];
    cellModel.index = 0;
    cellModel.leftMsg = @"Firmware version";
    cellModel.rightMsg = SafeStr(self.deviceBleInfo[@"data"][@"firmware_version"]);
    cellModel.rightButtonTitle = @"DFU";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Hardware version";
    cellModel1.rightMsg = SafeStr(self.deviceBleInfo[@"data"][@"hardware_version"]);
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Software version";
    cellModel2.rightMsg = SafeStr(self.deviceBleInfo[@"data"][@"software_version"]);
    [self.section2List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"MAC address";
    cellModel3.rightMsg = SafeStr(self.deviceBleInfo[@"data"][@"mac"]);
    [self.section2List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"Battery voltage";
    cellModel4.rightMsg = @"";
    [self.section2List addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.leftMsg = @"Sensor status";
    
    NSString *hex = [MKBLEBaseSDKAdopter fetchHexValue:[self.deviceBleInfo[@"data"][@"sensor_status"] integerValue] byteLen:1];
    NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:hex];
    
    NSMutableArray *tempList = [NSMutableArray array];
    
    if ([[binary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"]) {
        [tempList addObject:@"ACC"];
    }
    
    if ([[binary substringWithRange:NSMakeRange(6, 1)] isEqualToString:@"1"]) {
        [tempList addObject:@"TH"];
    }
    
    if ([[binary substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]) {
        [tempList addObject:@"Light"];
    }
            
    cellModel5.rightMsg = [tempList componentsJoinedByString:@"&"];
    [self.section2List addObject:cellModel5];
}

- (void)loadSection3Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"Real time TH data";
    [self.section3List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Historical TH data";
    [self.section3List addObject:cellModel2];
    
    MKSettingTextCellModel *cellModel3 = [[MKSettingTextCellModel alloc] init];
    cellModel3.leftMsg = @"Accelerometer data";
    [self.section3List addObject:cellModel3];
    
    MKSettingTextCellModel *cellModel4 = [[MKSettingTextCellModel alloc] init];
    cellModel4.leftMsg = @"TH data sample rate";
    [self.section3List addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"Advertisement parameters";
    [self.section3List addObject:cellModel5];
    
    MKSettingTextCellModel *cellModel6 = [[MKSettingTextCellModel alloc] init];
    cellModel6.leftMsg = @"Power off";
    [self.section3List addObject:cellModel6];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKGWDeviceModeManager shared].deviceName;
    [self.rightButton setTitle:@"Disconnect" forState:UIControlStateNormal];
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
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

@end
