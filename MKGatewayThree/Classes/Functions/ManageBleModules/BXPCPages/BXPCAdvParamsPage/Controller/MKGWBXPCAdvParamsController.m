//
//  MKGWBXPCAdvParamsController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPCAdvParamsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"

#import "MKGWBXPAdvParamsCell.h"

#import "MKGWDeviceModeManager.h"
#import "MKGWDeviceModel.h"

#import "MKGWMQTTInterface.h"

#import "MKGWCAdvParamsModel.h"

@interface MKGWBXPCAdvParamsController ()<UITableViewDelegate,
UITableViewDataSource,
MKGWBXPAdvParamsCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKGWCAdvParamsModel *dataModel;

@end

@implementation MKGWBXPCAdvParamsController

- (void)dealloc {
    NSLog(@"MKGWBXPCAdvParamsController销毁");
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
    MKGWBXPAdvParamsCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKGWBXPAdvParamsCell *cell = [MKGWBXPAdvParamsCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKGWBXPAdvParamsCellDelegate
/// set按钮点击事件
/// - Parameters:
///   - slotIndex: slotIndex
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power
/*
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:3dBm
 8:4dBm
 */
- (void)gw_BXPAdvParamsCell_setPressedWithSlotIndex:(NSInteger)slotIndex
                                           interval:(NSString *)interval
                                            txPower:(NSInteger)txPower {
    if (!ValidStr(interval) || [interval integerValue] < 1 || [interval integerValue] > 100) {
        [self.view showCentralToast:@"ADV interval Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKGWMQTTInterface gw_configBXPCAdvParamsWithChannel:slotIndex interval:[interval integerValue] txPower:txPower bleMac:self.bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
- (void)loadSectionDatas {
    for (NSInteger i = 0; i < self.dataModel.dataList.count; i ++) {
        NSDictionary *dic = self.dataModel.dataList[i];
        MKGWBXPAdvParamsCellModel *cellModel = [[MKGWBXPAdvParamsCellModel alloc] init];
        cellModel.slotIndex = [dic[@"channel"] integerValue];
        MKGWBXPAdvParamsCellSlotType slotType = [self fetchSlotType:[dic[@"channel_type"] integerValue]];
        cellModel.slotType = slotType;
        if (slotType != MKGWBXPAdvParamsCellSlotTypeNoData) {
            cellModel.triggerType = [dic[@"trigger_type"] integerValue];
            cellModel.interval = [NSString stringWithFormat:@"%ld",(long)([dic[@"adv_interval"] integerValue] / 100)];
            cellModel.txPower = [self fetchTxPower:[dic[@"tx_power"] integerValue]];
        }
        [self.dataList addObject:cellModel];
    }
        
    [self.tableView reloadData];
}

#pragma mark - private method
- (MKGWBXPAdvParamsCellSlotType)fetchSlotType:(NSInteger)slotType {
    if (slotType == 0x00) {
        return MKGWBXPAdvParamsCellSlotTypeUID;
    }
    if (slotType == 0x10) {
        return MKGWBXPAdvParamsCellSlotTypeURL;
    }
    if (slotType == 0x20) {
        return MKGWBXPAdvParamsCellSlotTypeTLM;
    }
    if (slotType == 0x30) {
        return MKGWBXPAdvParamsCellSlotTypeEID;
    }
    if (slotType == 0x40) {
        return MKGWBXPAdvParamsCellSlotTypeDeviceInfo;
    }
    if (slotType == 0x50) {
        return MKGWBXPAdvParamsCellSlotTypeiBeacon;
    }
    if (slotType == 0x60) {
        return MKGWBXPAdvParamsCellSlotTypeAccelerometer;
    }
    if (slotType == 0x70) {
        return MKGWBXPAdvParamsCellSlotTypeHT;
    }
    if (slotType == 0xff) {
        return MKGWBXPAdvParamsCellSlotTypeNoData;
    }
    return MKGWBXPAdvParamsCellSlotTypeNoData;
}

- (NSInteger)fetchTxPower:(NSInteger)txPower {
    if (txPower == -20) {
        return 1;
    }
    if (txPower == -16) {
        return 2;
    }
    if (txPower == -12) {
        return 3;
    }
    if (txPower == -8) {
        return 4;
    }
    if (txPower == -4) {
        return 5;
    }
    if (txPower == 0) {
        return 6;
    }
    if (txPower == 3) {
        return 7;
    }
    if (txPower == 4) {
        return 8;
    }
    return 0;
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

- (MKGWCAdvParamsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWCAdvParamsModel alloc] init];
    }
    return _dataModel;
}

@end
