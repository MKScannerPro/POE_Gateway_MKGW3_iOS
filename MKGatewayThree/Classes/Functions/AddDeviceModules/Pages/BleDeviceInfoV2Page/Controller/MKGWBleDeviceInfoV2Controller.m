//
//  MKGWBleDeviceInfoV2Controller.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/16.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleDeviceInfoV2Controller.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"

#import "MKGWBleDeviceInfoV2Model.h"

@interface MKGWBleDeviceInfoV2Controller ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKGWBleDeviceInfoV2Model *dataModel;

@end

@implementation MKGWBleDeviceInfoV2Controller

- (void)dealloc {
    NSLog(@"MKGWBleDeviceInfoV2Controller销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
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

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Device name";
    cellModel1.rightMsg = self.dataModel.deviceName;
    [self.dataList addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Product model";
    cellModel2.rightMsg = self.dataModel.productMode;
    [self.dataList addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"Manufacturer";
    cellModel3.rightMsg = self.dataModel.manu;
    [self.dataList addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"Software version";
    cellModel4.rightMsg = self.dataModel.software;
    [self.dataList addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.leftMsg = @"Hardware version";
    cellModel5.rightMsg = self.dataModel.hardware;
    [self.dataList addObject:cellModel5];
    
    MKNormalTextCellModel *cellModel6 = [[MKNormalTextCellModel alloc] init];
    cellModel6.leftMsg = @"WIFI Firmware version";
    cellModel6.rightMsg = self.dataModel.wifiFirmware;
    [self.dataList addObject:cellModel6];
    
    MKNormalTextCellModel *cellModel7 = [[MKNormalTextCellModel alloc] init];
    cellModel7.leftMsg = @"BLE Firmware version";
    cellModel7.rightMsg = self.dataModel.bleFirmware;
    [self.dataList addObject:cellModel7];
    
    MKNormalTextCellModel *cellModel8 = [[MKNormalTextCellModel alloc] init];
    cellModel8.leftMsg = @"WIFI MAC";
    cellModel8.rightMsg = self.dataModel.wifiStaMac;
    [self.dataList addObject:cellModel8];
    
    MKNormalTextCellModel *cellModel9 = [[MKNormalTextCellModel alloc] init];
    cellModel9.leftMsg = @"Ethernet MAC";
    cellModel9.rightMsg = self.dataModel.ethernetMac;
    [self.dataList addObject:cellModel9];
    
    MKNormalTextCellModel *cellModel10 = [[MKNormalTextCellModel alloc] init];
    cellModel10.leftMsg = @"BT MAC";
    cellModel10.rightMsg = self.dataModel.btMac;
    [self.dataList addObject:cellModel10];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Device Information";
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

- (MKGWBleDeviceInfoV2Model *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWBleDeviceInfoV2Model alloc] init];
    }
    return _dataModel;
}

@end
