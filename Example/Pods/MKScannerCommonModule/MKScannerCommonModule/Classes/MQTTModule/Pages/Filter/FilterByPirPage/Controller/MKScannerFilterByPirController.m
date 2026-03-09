//
//  MKScannerFilterByPirController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerFilterByPirController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTextButtonCell.h"

#import "MKFilterBeaconCell.h"

@interface MKScannerFilterByPirController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKTextButtonCellDelegate,
MKFilterBeaconCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)id <MKScannerFilterByPirProtocol>protocol;

@end

@implementation MKScannerFilterByPirController

- (void)dealloc {
    NSLog(@"MKScannerFilterByPirController销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerFilterByPirProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self configDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 70.f;
    }
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKFilterBeaconCell *cell = [MKFilterBeaconCell initCellWithTableView:tableView];
    cell.dataModel = self.section2List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //
        self.protocol.isOn = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    MKTextButtonCellModel *cellModel = self.section1List[index];
    cellModel.dataListIndex = dataListIndex;
    if (index == 0) {
        //Delay response status
        self.protocol.delayRespneseStatus = dataListIndex;
        return;
    }
    if (index == 1) {
        //Door open/close status
        self.protocol.doorStatus = dataListIndex;
        return;
    }
    if (index == 2) {
        //Sensor sensitivity
        self.protocol.sensorSensitivity = dataListIndex;
        return;
    }
    if (index == 3) {
        //Detection status
        self.protocol.sensorDetectionStatus = dataListIndex;
        return;
    }
}

#pragma mark - MKFilterBeaconCellDelegate
- (void)mk_beaconMinValueChanged:(NSString *)value index:(NSInteger)index {
    MKFilterBeaconCellModel *cellModel = self.section2List[index];
    cellModel.minValue = value;
    if (index == 0) {
        //Major
        self.protocol.minMajor = value;
        return;
    }
    if (index == 1) {
        //Minor
        self.protocol.minMinor = value;
        return;
    }
}

- (void)mk_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index {
    MKFilterBeaconCellModel *cellModel = self.section2List[index];
    cellModel.maxValue = value;
    if (index == 0) {
        //Major
        self.protocol.maxMajor = value;
        return;
    }
    if (index == 1) {
        //Minor
        self.protocol.maxMinor = value;
        return;
    }
}

#pragma mark - interface
- (void)readDataFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    }
                            failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)configDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Setup succeed!"];
    }
                              failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"PIR Presence";
    cellModel.isOn = self.protocol.isOn;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Delay response status";
    cellModel1.dataList = @[@"low delay",@"medium delay",@"high delay",@"all"];
    cellModel1.dataListIndex = self.protocol.delayRespneseStatus;
    cellModel1.buttonLabelFont = MKFont(13.f);
    [self.section1List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Door open/close status";
    cellModel2.dataList = @[@"close",@"open",@"all"];
    cellModel2.dataListIndex = self.protocol.doorStatus;
    cellModel2.buttonLabelFont = MKFont(13.f);
    [self.section1List addObject:cellModel2];
    
    MKTextButtonCellModel *cellModel3 = [[MKTextButtonCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Sensor sensitivity";
    cellModel3.dataList = @[@"low",@"medium",@"high",@"all"];
    cellModel3.dataListIndex = self.protocol.sensorSensitivity;
    cellModel3.buttonLabelFont = MKFont(13.f);
    [self.section1List addObject:cellModel3];
    
    MKTextButtonCellModel *cellModel4 = [[MKTextButtonCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.msg = @"Detection status";
    cellModel4.dataList = @[@"no motion detected",@"motion detected",@"all"];
    cellModel4.dataListIndex = self.protocol.sensorDetectionStatus;
    cellModel4.buttonLabelFont = MKFont(13.f);
    [self.section1List addObject:cellModel4];
}

- (void)loadSection2Datas {
    MKFilterBeaconCellModel *cellModel1 = [[MKFilterBeaconCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Major";
    cellModel1.minValue = self.protocol.minMajor;
    cellModel1.maxValue = self.protocol.maxMajor;
    [self.section2List addObject:cellModel1];
    
    MKFilterBeaconCellModel *cellModel2 = [[MKFilterBeaconCellModel alloc] init];
    cellModel2.msg = @"Minor";
    cellModel2.index = 1;
    cellModel2.minValue = self.protocol.minMinor;
    cellModel2.maxValue = self.protocol.maxMinor;
    [self.section2List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"PIR Presence";
    [self.rightButton setImage:LOADICON(@"MKScannerCommonModule", @"MKScannerFilterByPirController", @"mk_scanner_saveIcon.png") forState:UIControlStateNormal];
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

@end
