//
//  MKScannerBXPDAdvParamsController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBXPDAdvParamsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"

#import "MKScannerBXPAdvParamsCell.h"

@interface MKScannerBXPDAdvParamsController ()<UITableViewDelegate,
UITableViewDataSource,
MKScannerBXPAdvParamsCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)id <MKScannerBXPDAdvParamsProtocol>protocol;

@end

@implementation MKScannerBXPDAdvParamsController

- (void)dealloc {
    NSLog(@"MKScannerBXPDAdvParamsController销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerBXPDAdvParamsProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
    }
    return self;
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
    MKScannerBXPAdvParamsCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKScannerBXPAdvParamsCell *cell = [MKScannerBXPAdvParamsCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKScannerBXPAdvParamsCellDelegate
/// set按钮点击事件
/// - Parameters:
///   - slotIndex: slotIndex
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power

- (void)mk_scanner_BXPAdvParamsCell_setPressedWithSlotIndex:(NSInteger)slotIndex
                                           interval:(NSString *)interval
                                            txPower:(NSInteger)txPower {
    if (!ValidStr(interval) || [interval integerValue] < 1 || [interval integerValue] > 100) {
        [self.view showCentralToast:@"ADV interval Error"];
        return;
    }
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol configAdvParamsWithChannel:slotIndex
                                     interval:[interval integerValue]
                                      txPower:txPower
                                     sucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    }
                                  failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol readAdvParamsWithSucBlock:^(NSArray * _Nonnull dataList) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas:dataList];
    }
                                 failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas:(NSArray *)list {
    for (NSInteger i = 0; i < list.count; i ++) {
        NSDictionary *dic = list[i];
        MKScannerBXPAdvParamsCellModel *cellModel = [[MKScannerBXPAdvParamsCellModel alloc] init];
        cellModel.slotIndex = [dic[@"channel"] integerValue];
        MKScannerBXPAdvParamsCellSlotType slotType = [self fetchSlotType:[dic[@"channel_type"] integerValue]];
        cellModel.slotType = slotType;
        if (slotType != MKScannerBXPAdvParamsCellSlotTypeNoData) {
            cellModel.triggerType = [dic[@"trigger_type"] integerValue];
            cellModel.interval = [NSString stringWithFormat:@"%ld",(long)([dic[@"adv_interval"] integerValue] / (self.protocol.multiples > 0 ? self.protocol.multiples : 1))];
            cellModel.txPower = [self fetchTxPower:[dic[@"tx_power"] integerValue]];
        }
        [self.dataList addObject:cellModel];
    }
        
    [self.tableView reloadData];
}

#pragma mark - private method
- (MKScannerBXPAdvParamsCellSlotType)fetchSlotType:(NSInteger)slotType {
    if (slotType == 0x00) {
        return MKScannerBXPAdvParamsCellSlotTypeUID;
    }
    if (slotType == 0x10) {
        return MKScannerBXPAdvParamsCellSlotTypeURL;
    }
    if (slotType == 0x20) {
        return MKScannerBXPAdvParamsCellSlotTypeTLM;
    }
    if (slotType == 0x30) {
        return MKScannerBXPAdvParamsCellSlotTypeEID;
    }
    if (slotType == 0x40) {
        return MKScannerBXPAdvParamsCellSlotTypeDeviceInfo;
    }
    if (slotType == 0x50) {
        return MKScannerBXPAdvParamsCellSlotTypeiBeacon;
    }
    if (slotType == 0x60) {
        return MKScannerBXPAdvParamsCellSlotTypeAccelerometer;
    }
    if (slotType == 0x70) {
        return MKScannerBXPAdvParamsCellSlotTypeHT;
    }
    if (slotType == 0xff) {
        return MKScannerBXPAdvParamsCellSlotTypeNoData;
    }
    return MKScannerBXPAdvParamsCellSlotTypeNoData;
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

@end
