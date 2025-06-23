//
//  MKGWBXPButtonCRController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/10.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKButtonMsgCell.h"
#import "MKTableSectionLineHeader.h"
#import "MKAlertView.h"
#import "MKSettingTextCell.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWButtonFirmwareCell.h"

#import "MKGWPressEventCountCell.h"

#import "MKGWButtonDFUV2Controller.h"
#import "MKGWBXPButtonCRRemoteReminderController.h"
#import "MKGWBXPButtonCRAccDataController.h"
#import "MKGWBXPButtonCRAdvParamsController.h"
#import "MKGWBXPButtonCRAlarmEventController.h"

@interface MKGWBXPButtonCRController ()<UITableViewDelegate,
UITableViewDataSource,
MKButtonMsgCellDelegate,
MKGWButtonFirmwareCellDelegate,
MKGWPressEventCountCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)NSDictionary *bxpStatusDic;

@end

@implementation MKGWBXPButtonCRController

- (void)dealloc {
    NSLog(@"MKGWBXPButtonCRController销毁");
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
    [self loadSectionDatas];
    [self addNotes];
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
    if (section == 3 || section == 6) {
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
    if (indexPath.section == 7 && indexPath.row == 0) {
        //Remote Reminder
        MKGWBXPButtonCRRemoteReminderController *vc = [[MKGWBXPButtonCRRemoteReminderController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 7 && indexPath.row == 1) {
        //Alarm Event
        MKGWBXPButtonCRAlarmEventController *vc = [[MKGWBXPButtonCRAlarmEventController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 7 && indexPath.row == 2) {
        //Accelerometer data
        MKGWBXPButtonCRAccDataController *vc = [[MKGWBXPButtonCRAccDataController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 7 && indexPath.row == 3) {
        //Advertisement parameters
        MKGWBXPButtonCRAdvParamsController *vc = [[MKGWBXPButtonCRAdvParamsController alloc] init];
        vc.bleMac = self.deviceBleInfo[@"data"][@"mac"];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (indexPath.section == 7 && indexPath.row == 4) {
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
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
    }
    if (section == 6) {
        return self.section6List.count;
    }
    if (section == 7) {
        return self.section7List.count;
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
    if (indexPath.section == 3) {
        MKButtonMsgCell *cell = [MKButtonMsgCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel =  self.section4List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 5) {
        MKGWPressEventCountCell *cell = [MKGWPressEventCountCell initCellWithTableView:tableView];
        cell.dataModel =  self.section5List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 6) {
        MKButtonMsgCell *cell = [MKButtonMsgCell initCellWithTableView:tableView];
        cell.dataModel =  self.section6List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKSettingTextCell *cell = [MKSettingTextCell initCellWithTableView:tableView];
    cell.dataModel =  self.section7List[indexPath.row];
    return cell;
}

#pragma mark - MKButtonMsgCellDelegate
/// 右侧按钮点击事件
/// @param index 当前cell所在index
- (void)mk_buttonMsgCellButtonPressed:(NSInteger)index {
    if (index == 0) {
        //Read battery and alarm info
        [self readDatasFromDevice];
        return;
    }
    if (index == 1) {
        //Dismiss alarm status
        [self dismissAlarmStatus];
        return;
    }
}

#pragma mark - MKGWButtonFirmwareCellDelegate
- (void)gw_buttonFirmwareCell_buttonAction:(NSInteger)index {
    if (index == 0) {
        //DFU
        MKGWButtonDFUV2Controller *vc = [[MKGWButtonDFUV2Controller alloc] init];
        vc.bleMacAddress = self.deviceBleInfo[@"data"][@"mac"];
        vc.type = 2;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - MKGWPressEventCountCellDelegate
- (void)gw_pressEventCountCell_clearButtonPressed:(NSInteger)index {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    
    [MKGWMQTTInterface gw_clearBXPButtonCREventCountWithType:index bleMacAddress:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        MKGWPressEventCountCellModel *cellModel = self.section5List[index];
        cellModel.count = @"0";
        [self.tableView mk_reloadRow:index inSection:5 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
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
    [MKGWMQTTInterface gw_readBXPButtonCRConnectedStatusWithBleMacAddress:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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

- (void)dismissAlarmStatus {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_dismissBXPButtonCRAlarmStatusWithBleMacAddress:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            [self.view showCentralToast:@"Read Failed"];
            return;
        }
        [self readDatasFromDevice];
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
    [MKGWMQTTInterface gw_bxpBtnCRRemotePowerOffWithBleMac:self.deviceBleInfo[@"data"][@"mac"] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.navigationController popViewControllerAnimated:YES];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateStatusDatas {
    MKNormalTextCellModel *cellModel1 = self.section4List[0];
    cellModel1.rightMsg = [NSString stringWithFormat:@"%@%@",self.bxpStatusDic[@"data"][@"battery_v"],@"mV"];
    
    MKGWPressEventCountCellModel *cellModel2 = self.section5List[0];
    cellModel2.count = [NSString stringWithFormat:@"%@",self.bxpStatusDic[@"data"][@"single_alarm_num"]];
    
    MKGWPressEventCountCellModel *cellModel3 = self.section5List[1];
    cellModel3.count = [NSString stringWithFormat:@"%@",self.bxpStatusDic[@"data"][@"double_alarm_num"]];
    
    MKGWPressEventCountCellModel *cellModel4 = self.section5List[2];
    cellModel4.count = [NSString stringWithFormat:@"%@",self.bxpStatusDic[@"data"][@"long_alarm_num"]];
    
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
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
    
    for (NSInteger i = 0; i < 8; i ++) {
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
}

- (void)loadSection3Datas {
    MKButtonMsgCellModel *cellModel = [[MKButtonMsgCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Read battery and alarm info";
    cellModel.buttonTitle = @"Read";
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftMsg = @"Battery voltage";
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKGWPressEventCountCellModel *cellModel1 = [[MKGWPressEventCountCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Single press event count";
    [self.section5List addObject:cellModel1];
    
    MKGWPressEventCountCellModel *cellModel2 = [[MKGWPressEventCountCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Double press event count";
    [self.section5List addObject:cellModel2];
    
    MKGWPressEventCountCellModel *cellModel3 = [[MKGWPressEventCountCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Long press event count";
    [self.section5List addObject:cellModel3];
}

- (void)loadSection6Datas {
    MKButtonMsgCellModel *cellModel = [[MKButtonMsgCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Dismiss alarm status";
    cellModel.buttonTitle = @"Dismiss";
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKSettingTextCellModel *cellModel1 = [[MKSettingTextCellModel alloc] init];
    cellModel1.leftMsg = @"Remote reminder";
    [self.section7List addObject:cellModel1];
    
    MKSettingTextCellModel *cellModel2 = [[MKSettingTextCellModel alloc] init];
    cellModel2.leftMsg = @"Alarm event data";
    [self.section7List addObject:cellModel2];
    
    MKSettingTextCellModel *cellModel3 = [[MKSettingTextCellModel alloc] init];
    cellModel3.leftMsg = @"Accelerometer data";
    [self.section7List addObject:cellModel3];
    
    MKSettingTextCellModel *cellModel4 = [[MKSettingTextCellModel alloc] init];
    cellModel4.leftMsg = @"Advertisement parameters";
    [self.section7List addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"Power off";
    [self.section7List addObject:cellModel5];
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

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)section6List {
    if (!_section6List) {
        _section6List = [NSMutableArray array];
    }
    return _section6List;
}

- (NSMutableArray *)section7List {
    if (!_section7List) {
        _section7List = [NSMutableArray array];
    }
    return _section7List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

@end
