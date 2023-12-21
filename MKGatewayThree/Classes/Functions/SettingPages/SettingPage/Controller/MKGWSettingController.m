//
//  MKGWSettingController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKSettingTextCell.h"
#import "MKTextSwitchCell.h"
#import "MKCustomUIAdopter.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertView.h"

#import "MKGWDeviceDatabaseManager.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

#import "MKGWIndicatorSettingsController.h"
#import "MKGWNetworkStatusController.h"
#import "MKGWReconnectTimeController.h"
#import "MKGWCommunicateController.h"
#import "MKGWDataReportController.h"
#import "MKGWSystemTimeController.h"
#import "MKGWAdvBeaconController.h"
#import "MKGWOTAController.h"
#import "MKGWMqttParamsListController.h"
#import "MKGWDeviceInfoController.h"

#import "MKGWSettingModel.h"

@interface MKGWSettingController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKGWSettingModel *dataModel;

@property (nonatomic, copy)NSString *localNameAsciiStr;

@end

@implementation MKGWSettingController

- (void)dealloc {
    NSLog(@"MKGWSettingController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self configLocalName];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        //Indicator settings
        MKGWIndicatorSettingsController *vc = [[MKGWIndicatorSettingsController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        //Network status report interval
        MKGWNetworkStatusController *vc = [[MKGWNetworkStatusController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        //Reconnect timeout
        MKGWReconnectTimeController *vc = [[MKGWReconnectTimeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        //Communicate timeout
        MKGWCommunicateController *vc = [[MKGWCommunicateController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        //Data report timeout
        MKGWDataReportController *vc = [[MKGWDataReportController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        //System time
        MKGWSystemTimeController *vc = [[MKGWSystemTimeController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        //Advertise iBeacon
        MKGWAdvBeaconController *vc = [[MKGWAdvBeaconController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        //OTA
        MKGWOTAController *vc = [[MKGWOTAController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        //Modify network settings
        MKGWMqttParamsListController *vc = [[MKGWMqttParamsListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        //Device information
        MKGWDeviceInfoController *vc = [[MKGWDeviceInfoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        return cell;
    }
    MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    return cell;
}

#pragma mark - event method
- (void)rootButtonPressed {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
        
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self rebootDevice];
    }];
    NSString *msg = @"Please confirm again whether to reboot the device.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Reboot Device" message:msg notificationName:@"mk_gw_needDismissAlert"];
}

- (void)resetButtonPressed {
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
        
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self resetDevice];
    }];
    NSString *msg = @"After reset, the device will be removed from the device list, and relevant data will be totally cleared.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView showAlertWithTitle:@"Reset Device" message:msg notificationName:@"mk_gw_needDismissAlert"];
}

#pragma mark - 修改设备本地名称
- (void)configLocalName{
    @weakify(self);
    MKAlertViewAction *cancelAction = [[MKAlertViewAction alloc] initWithTitle:@"Cancel" handler:^{
    }];
    
    MKAlertViewAction *confirmAction = [[MKAlertViewAction alloc] initWithTitle:@"Confirm" handler:^{
        @strongify(self);
        [self saveDeviceLocalName];
    }];
    self.localNameAsciiStr = SafeStr([MKGWDeviceModeManager shared].deviceName);
    MKAlertViewTextField *textField = [[MKAlertViewTextField alloc] initWithTextValue:SafeStr([MKGWDeviceModeManager shared].deviceName)
                                                                          placeholder:@"1-20 characters"
                                                                        textFieldType:mk_normal
                                                                            maxLength:20
                                                                              handler:^(NSString * _Nonnull text) {
        @strongify(self);
        self.localNameAsciiStr = text;
    }];
    
    NSString *msg = @"Note:The local name should be 1-20 characters.";
    MKAlertView *alertView = [[MKAlertView alloc] init];
    [alertView addAction:cancelAction];
    [alertView addAction:confirmAction];
    [alertView addTextField:textField];
    [alertView showAlertWithTitle:@"Edit Local Name" message:msg notificationName:@"mk_gw_needDismissAlert"];
}

- (void)saveDeviceLocalName {
    if (!ValidStr(self.localNameAsciiStr) || self.localNameAsciiStr.length > 20) {
        [self.view showCentralToast:@"The local name should be 1-20 characters."];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Save..." inView:self.view isPenetration:NO];
    [MKGWDeviceDatabaseManager updateLocalName:self.localNameAsciiStr
                                    macAddress:[MKGWDeviceModeManager shared].macAddress
                                      sucBlock:^{
        [[MKHudManager share] hide];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_gw_deviceNameChangedNotification"
                                                            object:nil
                                                          userInfo:@{
                                                              @"macAddress":[MKGWDeviceModeManager shared].macAddress,
                                                              @"deviceName":self.localNameAsciiStr
                                                          }];
    }
                                   failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 设备复位
- (void)resetDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_resetDeviceWithMacAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self removeDevice];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)removeDevice {
    [[MKHudManager share] showHUDWithTitle:@"Delete..." inView:self.view isPenetration:NO];
    [MKGWDeviceDatabaseManager deleteDeviceWithMacAddress:[MKGWDeviceModeManager shared].macAddress sucBlock:^{
        [[MKHudManager share] hide];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_gw_deleteDeviceNotification"
                                                            object:nil
                                                          userInfo:@{@"macAddress":[MKGWDeviceModeManager shared].macAddress}];
        [self popToViewControllerWithClassName:@"MKGWDeviceListController"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 设备重启
- (void)rebootDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_rebootDeviceWithMacAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success!"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSections
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    for (NSInteger i = 0; i < 3; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
        
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"Indicator settings";
    [self.section0List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Network status report interval";
    [self.section0List addObject:cellModel2];
    
    MKSettingTextCellModel *cellModel3 = [[MKSettingTextCellModel alloc] init];
    cellModel3.leftMsg = @"Reconnect timeout";
    [self.section0List addObject:cellModel3];
    
    MKSettingTextCellModel *cellModel4 = [[MKSettingTextCellModel alloc] init];
    cellModel4.leftMsg = @"Communication timeout";
    [self.section0List addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"Data report timeout";
    [self.section0List addObject:cellModel5];
    
    MKSettingTextCellModel *cellModel6 = [[MKSettingTextCellModel alloc] init];
    cellModel6.leftMsg = @"System time";
    [self.section0List addObject:cellModel6];
    
    MKSettingTextCellModel *cellModel7 = [[MKSettingTextCellModel alloc] init];
    cellModel7.leftMsg = @"Advertise iBeacon";
    [self.section0List addObject:cellModel7];
}

- (void)loadSection1Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"OTA";
    [self.section1List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Modify Network Settings";
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKSettingTextCellModel *cellModel = [[MKSettingTextCellModel alloc] init];
    cellModel.leftMsg = @"Device information";
    [self.section2List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Settings";
    [self.rightButton setImage:LOADICON(@"MKGatewayThree", @"MKGWSettingController", @"gw_editIcon.png") forState:UIControlStateNormal];
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
        
        _tableView.tableFooterView = [self tableFooterView];
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKGWSettingModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWSettingModel alloc] init];
    }
    return _dataModel;
}

- (UIView *)tableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 100.f)];
    footerView.backgroundColor = RGBCOLOR(242, 242, 242);
    
    CGFloat buttonHeight = 35.f;
    CGFloat buttonWidth = 120.f;
    CGFloat offsetX = (kViewWidth - buttonWidth) / 2;
    UIButton *rootButton = [MKCustomUIAdopter customButtonWithTitle:@"Reboot"
                                                             target:self
                                                             action:@selector(rootButtonPressed)];
    rootButton.frame = CGRectMake(offsetX, 15.f, buttonWidth, buttonHeight);
    [footerView addSubview:rootButton];
    
    UIButton *resetButton = [MKCustomUIAdopter customButtonWithTitle:@"Reset Device"
                                                              target:self
                                                              action:@selector(resetButtonPressed)];
    resetButton.frame = CGRectMake(offsetX, 15.f + buttonHeight + 20.f, buttonWidth, buttonHeight);
    [footerView addSubview:resetButton];
    
    return footerView;
}

@end
