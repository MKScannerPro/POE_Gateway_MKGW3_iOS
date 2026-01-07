//
//  MKGWBXPButtonCRRemoteReminderController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRRemoteReminderController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTableSectionLineHeader.h"
#import "MKTextFieldCell.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

#import "MKGWBXPButtonCRRemoteReminderModel.h"

#import "MKGWRemoteReminderCell.h"

@interface MKGWBXPButtonCRRemoteReminderController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKGWRemoteReminderCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKGWBXPButtonCRRemoteReminderModel *dataModel;

@end

@implementation MKGWBXPButtonCRRemoteReminderController

- (void)dealloc {
    NSLog(@"MKGWBXPButtonCRRemoteReminderController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self loadNumberOfRows:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //LED notification
        MKGWRemoteReminderCell *cell = [MKGWRemoteReminderCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        //Buzzer notification
        MKGWRemoteReminderCell *cell = [MKGWRemoteReminderCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        //Vibration notification
        MKGWRemoteReminderCell *cell = [MKGWRemoteReminderCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.section5List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Blinking time
        self.dataModel.blinkingTime = value;
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Blinking interval
        self.dataModel.blinkingInterval = value;
        MKTextFieldCellModel *cellModel = self.section1List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 2) {
        //Ringing time
        self.dataModel.ringingTime = value;
        MKTextFieldCellModel *cellModel = self.section3List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 3) {
        //Ringing Interval
        self.dataModel.ringingInterval = value;
        MKTextFieldCellModel *cellModel = self.section3List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 4) {
        //Vibrating time
        self.dataModel.vibrationTime = value;
        MKTextFieldCellModel *cellModel = self.section5List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 5) {
        //Vibrating Interval
        self.dataModel.vibrationInterval = value;
        MKTextFieldCellModel *cellModel = self.section5List[1];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - MKGWRemoteReminderCellDelegate
- (void)bxd_remindButtonPressed:(NSInteger)index {
    if (index == 0) {
        [self reminderLED];
        return;
    }
    if (index == 1) {
        [self reminderBuzzer];
        return;
    }
    if (index == 2) {
        [self reminderVibration];
        return;
    }
}

#pragma mark - loadCellDatas
- (NSInteger)loadNumberOfRows:(NSInteger)section {
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
    return 0;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 2 || section == 4) {
        return 10.f;
    }
    return 0;
}

#pragma mark - interface

- (void)reminderLED {
    if (!ValidStr(self.dataModel.blinkingTime) || [self.dataModel.blinkingTime integerValue] < 1 || [self.dataModel.blinkingTime integerValue] > 6000) {
        [self.view showCentralToast:@"Blink Time Error"];
        return ;
    }
    if (!ValidStr(self.dataModel.blinkingInterval) || [self.dataModel.blinkingInterval integerValue] < 0 || [self.dataModel.blinkingInterval integerValue] > 100) {
        [self.view showCentralToast:@"Blink Interval Error"];
        return ;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_bxpBtnCRLedRemoteReminderWithBleMac:self.bleMac blinkingTime:[self.dataModel.blinkingTime integerValue] blinkingInterval:[self.dataModel.blinkingInterval integerValue] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)reminderBuzzer {
    if (!ValidStr(self.dataModel.ringingTime) || [self.dataModel.ringingTime integerValue] < 1 || [self.dataModel.ringingTime integerValue] > 6000) {
        [self.view showCentralToast:@"Ringing Time Error"];
        return ;
    }
    if (!ValidStr(self.dataModel.ringingInterval) || [self.dataModel.ringingInterval integerValue] < 0 || [self.dataModel.ringingInterval integerValue] > 100) {
        [self.view showCentralToast:@"Ringing Interval Error"];
        return ;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_bxpBtnCRBuzzerRemoteReminderWithBleMac:self.bleMac ringTime:[self.dataModel.ringingTime integerValue] ringInterval:[self.dataModel.ringingInterval integerValue] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)reminderVibration {
    if (!ValidStr(self.dataModel.vibrationTime) || [self.dataModel.vibrationTime integerValue] < 1 || [self.dataModel.vibrationTime integerValue] > 6000) {
        [self.view showCentralToast:@"Vibration Time Error"];
        return ;
    }
    if (!ValidStr(self.dataModel.vibrationInterval) || [self.dataModel.vibrationInterval integerValue] < 0 || [self.dataModel.vibrationInterval integerValue] > 100) {
        [self.view showCentralToast:@"Vibration Interval Error"];
        return ;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_bxpBtnCRVibratingRemoteReminderWithBleMac:self.bleMac vibratingTime:[self.dataModel.vibrationTime integerValue] vibratingInterval:[self.dataModel.vibrationInterval integerValue] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    
    for (NSInteger i = 0; i < 6; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKGWRemoteReminderCellModel *cellModel = [[MKGWRemoteReminderCellModel alloc] init];
    cellModel.msg = @"LED notification";
    cellModel.index = 0;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Blinking time";
    cellModel1.textPlaceholder = @"1~6000";
    cellModel1.textFieldValue = self.dataModel.blinkingTime;
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.unit = @"x100ms";
    cellModel1.maxLength = 4;
    [self.section1List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Blinking interval";
    cellModel2.textPlaceholder = @"0~100";
    cellModel2.textFieldValue = self.dataModel.blinkingInterval;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @"x100ms";
    cellModel2.maxLength = 3;
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKGWRemoteReminderCellModel *cellModel = [[MKGWRemoteReminderCellModel alloc] init];
    cellModel.msg = @"Buzzer notification";
    cellModel.index = 1;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 2;
    cellModel1.msg = @"Ringing time";
    cellModel1.textPlaceholder = @"1~6000";
    cellModel1.textFieldValue = self.dataModel.ringingTime;
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.unit = @"x100ms";
    cellModel1.maxLength = 4;
    [self.section3List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 3;
    cellModel2.msg = @"Ringing interval";
    cellModel2.textPlaceholder = @"0~100";
    cellModel2.textFieldValue = self.dataModel.ringingInterval;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @"x100ms";
    cellModel2.maxLength = 3;
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKGWRemoteReminderCellModel *cellModel = [[MKGWRemoteReminderCellModel alloc] init];
    cellModel.msg = @"Vibration notification";
    cellModel.index = 2;
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 4;
    cellModel1.msg = @"Vibrating time";
    cellModel1.textPlaceholder = @"1~6000";
    cellModel1.textFieldValue = self.dataModel.vibrationTime;
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.unit = @"x100ms";
    cellModel1.maxLength = 4;
    [self.section5List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 5;
    cellModel2.msg = @"Vibrating interval";
    cellModel2.textPlaceholder = @"0~100";
    cellModel2.textFieldValue = self.dataModel.vibrationInterval;
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.unit = @"x100ms";
    cellModel2.maxLength = 3;
    [self.section5List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Remote reminder";
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
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
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
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

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKGWBXPButtonCRRemoteReminderModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWBXPButtonCRRemoteReminderModel alloc] init];
    }
    return _dataModel;
}

@end
