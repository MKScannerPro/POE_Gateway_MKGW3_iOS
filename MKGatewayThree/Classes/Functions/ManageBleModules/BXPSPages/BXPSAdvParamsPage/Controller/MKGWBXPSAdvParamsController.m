//
//  MKGWBXPSAdvParamsController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSAdvParamsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTableSectionLineHeader.h"

#import "MKGWAdvNormalCell.h"
#import "MKGWAdvTriggerCell.h"
#import "MKGWAdvTriggerTwoStateCell.h"

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWMQTTInterface.h"

#import "MKGWBXPSAdvParamsModel.h"

@interface MKGWBXPSAdvParamsController ()<UITableViewDelegate,
UITableViewDataSource,
MKGWAdvNormalCellDelegate,
MKGWAdvTriggerCellDelegate,
MKGWAdvTriggerTwoStateCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKGWBXPSAdvParamsModel *dataModel;

@end

@implementation MKGWBXPSAdvParamsController

- (void)dealloc {
    NSLog(@"MKGWBXPSAdvParamsController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self loadTableCellHeight:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
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
    return [self loadTableCell:indexPath];
}

#pragma mark - MKGWAdvNormalCellDelegate
- (void)gw_advNormalCell_setPressed:(NSInteger)index
                           interval:(NSString *)interval
                            txPower:(NSInteger)txPower {
    if (!ValidStr(interval) || [interval integerValue] < 1 || [interval integerValue] > 100) {
        [self.view showCentralToast:@"ADV interval Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    NSDictionary *param = @{
        @"channel":@(index),
        @"channelType":@(0),
        @"advInterval":@([interval integerValue] * 20),
        @"txPower":@(txPower)
    };
    [MKGWMQTTInterface gw_bxpBtnConfigAdvParamsWithParams:param bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - MKGWAdvTriggerCellDelegate
- (void)gw_advTriggerCell_setPressed:(NSInteger)index
                            interval:(NSString *)interval
                             txPower:(NSInteger)txPower {
    if (!ValidStr(interval) || [interval integerValue] < 1 || [interval integerValue] > 100) {
        [self.view showCentralToast:@"ADV interval Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    NSDictionary *param = @{
        @"channel":@(index),
        @"channelType":@(1),
        @"advInterval":@([interval integerValue] * 20),
        @"txPower":@(txPower)
    };
    [MKGWMQTTInterface gw_bxpBtnConfigAdvParamsWithParams:param bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - MKGWAdvTriggerTwoStateCellDelegate
- (void)gw_advNormalCell_setPressed:(NSInteger)index
                     beforeInterval:(NSString *)beforeInterval
                      beforeTxPower:(NSInteger)beforeTxPower
                      afterInterval:(NSString *)afterInterval
                       afterTxPower:(NSInteger)afterTxPower {
    if (!ValidStr(beforeInterval) || [beforeInterval integerValue] < 1 || [beforeInterval integerValue] > 100) {
        [self.view showCentralToast:@"Before ADV interval Error"];
        return;
    }
    if (!ValidStr(afterInterval) || [afterInterval integerValue] < 1 || [afterInterval integerValue] > 100) {
        [self.view showCentralToast:@"After ADV interval Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    NSDictionary *param = @{
        @"channel":@(index),
        @"channelType":@(2),
        @"afterAdvInterval":@([afterInterval integerValue] * 20),
        @"afterTxPower":@(afterTxPower),
        @"beforeAdvInterval":@([beforeInterval integerValue] * 20),
        @"beforeTxPower":@(beforeTxPower)
    };
    [MKGWMQTTInterface gw_bxpBtnConfigAdvParamsWithParams:param bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithBleMac:self.bleMac sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (UITableViewCell *)loadTableCell:(NSIndexPath *)indexPath {
    NSDictionary *advParams = @{};
    for (NSDictionary *dic in self.dataModel.dataList) {
        if ([dic[@"channel"] integerValue] == indexPath.section) {
            advParams = dic;
            break;
        }
    }
    if (!ValidDict(advParams)) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWBXPSAdvParamsControllerCell"];
    }
    BOOL enable = [advParams[@"enable"] boolValue];
    NSMutableArray *dataList = self.section0List;
    if (indexPath.section == 1) {
        dataList = self.section1List;
    }else if (indexPath.section == 2) {
        dataList = self.section2List;
    }else if (indexPath.section == 3) {
        dataList = self.section3List;
    }
    if (!enable) {
        //关闭状态
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:self.tableView];
        cell.dataModel = dataList[indexPath.row];
        return cell;
    }
    NSInteger channelType = [advParams[@"channel_type"] integerValue];
    if (channelType == 0) {
        //正常广播
        MKGWAdvNormalCell *cell = [MKGWAdvNormalCell initCellWithTableView:self.tableView];
        cell.dataModel = dataList[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (channelType == 1) {
        //触发广播
        MKGWAdvTriggerCell *cell = [MKGWAdvTriggerCell initCellWithTableView:self.tableView];
        cell.dataModel = dataList[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    //触发前+触发后广播
    MKGWAdvTriggerTwoStateCell *cell = [MKGWAdvTriggerTwoStateCell initCellWithTableView:self.tableView];
    cell.dataModel = dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)loadTableCellHeight:(NSIndexPath *)indexPath {
    NSMutableArray *dataList = self.section0List;
    if (indexPath.section == 1) {
        dataList = self.section1List;
    }else if (indexPath.section == 2) {
        dataList = self.section2List;
    }else if (indexPath.section == 3) {
        dataList = self.section3List;
    }
    NSObject *obj = dataList[indexPath.row];
    if ([obj isKindOfClass:MKNormalTextCellModel.class]) {
        return 44.f;
    }
    if ([obj isKindOfClass:MKGWAdvNormalCellModel.class] || [obj isKindOfClass:MKGWAdvTriggerCellModel.class]) {
        return 150.f;
    }
    if ([obj isKindOfClass:MKGWAdvTriggerTwoStateCellModel.class]) {
        return 240.f;
    }
    return 0.0f;
}

- (void)loadSectionDatas {
    [self.section0List addObject:[self loadObjectWithSection:0]];
    [self.section1List addObject:[self loadObjectWithSection:1]];
    [self.section2List addObject:[self loadObjectWithSection:2]];
    [self.section3List addObject:[self loadObjectWithSection:3]];
    
    for (NSInteger i = 0; i < 4; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
        
    [self.tableView reloadData];
}

- (NSObject *)loadObjectWithSection:(NSInteger)section {
    NSDictionary *advParams = @{};
    for (NSDictionary *dic in self.dataModel.dataList) {
        if ([dic[@"channel"] integerValue] == section) {
            advParams = dic;
            break;
        }
    }
    if (!ValidDict(advParams)) {
        return [[NSObject alloc] init];
    }
    NSString *channelMsg = @"Single press mode";
    if (section == 1) {
        channelMsg = @"Double press mode";
    }else if (section == 2) {
        channelMsg = @"Long press mode";
    }else if (section == 3) {
        channelMsg = @"Abnormal inactivity mode";
    }
    BOOL enable = [advParams[@"enable"] boolValue];
    if (!enable) {
        //关闭状态
        MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
        cellModel.leftMsg = channelMsg;
        cellModel.rightMsg = @"OFF";
        return cellModel;
    }
    NSInteger channelType = [advParams[@"channel_type"] integerValue];
    if (channelType == 0) {
        //正常广播
        MKGWAdvNormalCellModel *cellModel = [[MKGWAdvNormalCellModel alloc] init];
        cellModel.index = section;
        cellModel.msg = channelMsg;
        cellModel.advInterval = [NSString stringWithFormat:@"%ld",(long)[advParams[@"normal_adv"][@"adv_interval"] integerValue] / 20];
        cellModel.txPower = [advParams[@"normal_adv"][@"tx_power"] integerValue];
        return cellModel;
    }
    if (channelType == 1) {
        //触发广播
        MKGWAdvTriggerCellModel *cellModel = [[MKGWAdvTriggerCellModel alloc] init];
        cellModel.index = section;
        cellModel.msg = channelMsg;
        cellModel.advInterval = [NSString stringWithFormat:@"%ld",(long)[advParams[@"trigger_after_adv"][@"adv_interval"] integerValue] / 20];
        cellModel.txPower = [advParams[@"trigger_after_adv"][@"tx_power"] integerValue];
        return cellModel;
    }
    //触发前+触发后广播
    MKGWAdvTriggerTwoStateCellModel *cellModel = [[MKGWAdvTriggerTwoStateCellModel alloc] init];
    cellModel.index = section;
    cellModel.msg = channelMsg;
    cellModel.beforeTriggerInterval = [NSString stringWithFormat:@"%ld",(long)[advParams[@"trigger_before_adv"][@"adv_interval"] integerValue] / 20];
    cellModel.beforeTriggerTxPower = [advParams[@"trigger_before_adv"][@"tx_power"] integerValue];
    cellModel.afterTriggerInterval = [NSString stringWithFormat:@"%ld",(long)[advParams[@"trigger_after_adv"][@"adv_interval"] integerValue] / 20];
    cellModel.afterTriggerTxPower = [advParams[@"trigger_after_adv"][@"tx_power"] integerValue];
    return cellModel;
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Advertisement parameters";
    self.titleLabel.font = MKFont(15.f);
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

- (MKGWBXPSAdvParamsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWBXPSAdvParamsModel alloc] init];
    }
    return _dataModel;
}

@end
