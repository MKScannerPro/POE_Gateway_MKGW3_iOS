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

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWMQTTInterface.h"

#import "MKGWBXPSAdvParamsModel.h"

#import "MKGWBXPSAdvNormalCell.h"
#import "MKGWBXPSAdvTriggerCell.h"
#import "MKGWBXPSAdvTriggerTwoStateCell.h"

@interface MKGWBXPSAdvParamsController ()<UITableViewDelegate,
UITableViewDataSource,
MKGWBXPSAdvNormalCellDelegate,
MKGWBXPSAdvTriggerCellDelegate,
MKGWBXPSAdvTriggerTwoStateCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self loadTableCell:indexPath];
}

#pragma mark - MKGWBXPSAdvNormalCellDelegate
/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power
/*
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 6
 */
- (void)gw_BXPSAdvNormalCell_setPressed:(NSInteger)index
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
    [MKGWMQTTInterface gw_configBXPSAdvParamsWithParams:param bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - MKGWBXPSAdvTriggerCellDelegate
/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power
/*
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 6
 */
- (void)gw_BXPSAdvTriggerCell_setPressed:(NSInteger)index
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
    [MKGWMQTTInterface gw_configBXPSAdvParamsWithParams:param bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - MKGWBXPSAdvTriggerTwoStateCellDelegate
/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - beforeInterval: ADV before triggered ADV interval
///   - beforeTxPower: ADV before triggered Tx Power
///   - afterInterval: ADV after triggered ADV interval
///   - afterTxPower: ADV after triggered Tx Power
/*
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 6
 */
- (void)gw_BXPSAdvTriggerTwoStateCell_setPressed:(NSInteger)index
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
    [MKGWMQTTInterface gw_configBXPSAdvParamsWithParams:param bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
    NSObject *obj = self.dataList[indexPath.row];
    if ([obj isKindOfClass:MKGWBXPSAdvNormalCellModel.class]) {
        //正常广播
        MKGWBXPSAdvNormalCell *cell = [MKGWBXPSAdvNormalCell initCellWithTableView:self.tableView];
        cell.dataModel = obj;
        cell.delegate = self;
        return cell;
    }
    if ([obj isKindOfClass:MKGWBXPSAdvTriggerCellModel.class]) {
        //触发广播
        MKGWBXPSAdvTriggerCell *cell = [MKGWBXPSAdvTriggerCell initCellWithTableView:self.tableView];
        cell.dataModel = obj;
        cell.delegate = self;
        return cell;
    }
    if ([obj isKindOfClass:MKGWBXPSAdvTriggerTwoStateCellModel.class]) {
        //触发前+触发后广播
        MKGWBXPSAdvTriggerTwoStateCell *cell = [MKGWBXPSAdvTriggerTwoStateCell initCellWithTableView:self.tableView];
        cell.dataModel = obj;
        cell.delegate = self;
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWBXPSAdvParamsControllerIdenty"];
}

- (CGFloat)loadTableCellHeight:(NSIndexPath *)indexPath {
    NSObject *obj = self.dataList[indexPath.row];
    if ([obj isKindOfClass:MKGWBXPSAdvNormalCellModel.class]) {
        //正常广播
        MKGWBXPSAdvNormalCellModel *tempModel = (MKGWBXPSAdvNormalCellModel *)obj;
        return [tempModel fetchCellHeight];
    }
    if ([obj isKindOfClass:MKGWBXPSAdvTriggerCellModel.class]) {
        //触发广播
        MKGWBXPSAdvTriggerCellModel *tempModel = (MKGWBXPSAdvTriggerCellModel *)obj;
        return [tempModel fetchCellHeight];
    }
    if ([obj isKindOfClass:MKGWBXPSAdvTriggerTwoStateCellModel.class]) {
        MKGWBXPSAdvTriggerTwoStateCellModel *tempModel = (MKGWBXPSAdvTriggerTwoStateCellModel *)obj;
        return [tempModel fetchCellHeight];
    }
    return 0.0f;
}

- (void)loadSectionDatas {
    for (NSInteger i = 0; i < self.dataModel.dataList.count; i ++) {
        NSDictionary *dic = self.dataModel.dataList[i];
        NSInteger channel = [dic[@"channel"] integerValue];
        BOOL enable = [dic[@"enable"] boolValue];
        if (!enable) {
            //通道关闭 No Data
            MKGWBXPSAdvNormalCellModel *cellModel = [[MKGWBXPSAdvNormalCellModel alloc] init];
            cellModel.slotIndex = channel;
            cellModel.slotType = MKGWBXPSAdvNormalCellSlotTypeNoData;
            [self.dataList addObject:cellModel];
        }else {
            //通道是打开的
            NSInteger channelType = [dic[@"channel_type"] integerValue];
            if (channelType == 0) {
                //正常广播
                MKGWBXPSAdvNormalCellModel *cellModel = [[MKGWBXPSAdvNormalCellModel alloc] init];
                cellModel.slotIndex = channel;
                
                NSDictionary *normalAdv = dic[@"normal_adv"];
                
                cellModel.slotType = [self loadAdvType:[normalAdv[@"adv_type"] integerValue]];
                cellModel.advInterval = [NSString stringWithFormat:@"%ld",(long)([normalAdv[@"adv_interval"] integerValue] / 20)];
                cellModel.txPower = [self fetchTxPower:[normalAdv[@"tx_power"] integerValue]];
                [self.dataList addObject:cellModel];
            }else if (channelType == 1) {
                //触发广播
                NSDictionary *afterAdv = dic[@"trigger_after_adv"];
                MKGWBXPSAdvTriggerCellModel *cellModel = [[MKGWBXPSAdvTriggerCellModel alloc] init];
                cellModel.slotIndex = channel;
                                
                cellModel.slotType = [self loadAdvType:[afterAdv[@"adv_type"] integerValue]];
                cellModel.advInterval = [NSString stringWithFormat:@"%ld",(long)([afterAdv[@"adv_interval"] integerValue] / 20)];
                cellModel.txPower = [self fetchTxPower:[afterAdv[@"tx_power"] integerValue]];
                [self.dataList addObject:cellModel];
            }else if (channelType == 2) {
                //触发前+触发后广播
                NSDictionary *beforeAdv = dic[@"trigger_before_adv"];
                NSDictionary *afterAdv = dic[@"trigger_after_adv"];
                MKGWBXPSAdvTriggerTwoStateCellModel *cellModel = [[MKGWBXPSAdvTriggerTwoStateCellModel alloc] init];
                cellModel.slotIndex = channel;
                cellModel.beforeSlotType = [self loadAdvType:[beforeAdv[@"adv_type"] integerValue]];
                cellModel.beforeTriggerInterval = [NSString stringWithFormat:@"%ld",(long)([beforeAdv[@"adv_interval"] integerValue] / 20)];
                cellModel.beforeTriggerTxPower = [self fetchTxPower:[beforeAdv[@"tx_power"] integerValue]];
                cellModel.afterSlotType = [self loadAdvType:[afterAdv[@"adv_type"] integerValue]];
                cellModel.afterTriggerInterval = [NSString stringWithFormat:@"%ld",(long)([afterAdv[@"adv_interval"] integerValue] / 20)];
                cellModel.afterTriggerTxPower = [self fetchTxPower:[afterAdv[@"tx_power"] integerValue]];
                [self.dataList addObject:cellModel];
            }
        }
    }
        
    [self.tableView reloadData];
}

- (NSInteger)loadAdvType:(NSInteger)advType {
    if (advType == 0x00) {
        return 0;
    }
    if (advType == 0x10) {
        return 1;
    }
    if (advType == 0x20) {
        return 2;
    }
    if (advType == 0x50) {
        return 3;
    }
    if (advType == 0x70) {
        return 4;
    }
    if (advType == 0x80) {
        return 5;
    }
    return 6;
}

- (NSInteger)fetchTxPower:(NSInteger)txPower {
    if (txPower == -20) {
        return 0;
    }
    if (txPower == -16) {
        return 1;
    }
    if (txPower == -12) {
        return 2;
    }
    if (txPower == -8) {
        return 3;
    }
    if (txPower == -4) {
        return 4;
    }
    if (txPower == 0) {
        return 5;
    }
    if (txPower == 3) {
        return 6;
    }
    if (txPower == 4) {
        return 7;
    }
    return 8;
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

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKGWBXPSAdvParamsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWBXPSAdvParamsModel alloc] init];
    }
    return _dataModel;
}

@end
