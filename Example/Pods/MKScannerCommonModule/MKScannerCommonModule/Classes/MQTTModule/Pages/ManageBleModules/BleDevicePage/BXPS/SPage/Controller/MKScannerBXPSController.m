//
//  MKScannerBXPSController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBXPSController.h"

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

#import "MKScannerButtonFirmwareCell.h"

#import "MKScannerButtonDFUV2Controller.h"
#import "MKScannerRealTimeTHDataController.h"
#import "MKScannerBXPSHistoricalTHDataController.h"
#import "MKScannerAccDataController.h"
#import "MKScannerTHDataSampleRateController.h"
#import "MKScannerBXPSHallCountController.h"
#import "MKScannerBXPSReminderController.h"
#import "MKScannerBXPSAdvParamsController.h"

@interface MKScannerBXPSController ()<UITableViewDelegate,
UITableViewDataSource,
MKScannerButtonFirmwareCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)id <MKScannerBXPSProtocol>protocol;

@property (nonatomic, strong)NSDictionary *bxpStatusDic;

@end

@implementation MKScannerBXPSController

- (void)dealloc {
    NSLog(@"MKScannerBXPSController销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerBXPSProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
        [self setupBlock];
    }
    return self;
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
    [alertView showAlertWithTitle:@"" message:msg notificationName:@"mk_scanner_needDismissAlert"];
}

- (void)leftButtonMethod {
    //用户点击左上角，则需要返回DeviceDataController
    for (UIViewController *vc in self.navigationController.viewControllers) {
        NSString *className = NSStringFromClass([vc class]);
        
        if ([className containsString:@"DeviceDataController"]) {
            // 如果类名包含 DeviceDataController，跳转到这个页面
            [self popToViewControllerWithClassName:className];
            break;
        }
    }
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
        id <MKScannerRealTimeTHDataProtocol>protocol = self.protocol.realTimeTHDataProtocol;
        if (protocol) {
            MKScannerRealTimeTHDataController *vc = [[MKScannerRealTimeTHDataController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        //Historical T&H data
        id <MKScannerBXPSHistoricalTHDataProtocol>protocol = self.protocol.historicalTHDataProtocol;
        if (protocol) {
            MKScannerBXPSHistoricalTHDataController *vc = [[MKScannerBXPSHistoricalTHDataController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 2) {
        //Accelerometer data
        id <MKScannerAccDataProtocol>protocol = self.protocol.accProtocol;
        if (protocol) {
            MKScannerAccDataController *vc = [[MKScannerAccDataController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 3) {
        //Hall sensor data
        id <MKScannerBXPSHallCountProtocol>protocol = self.protocol.hallCountProtocol;
        if (protocol) {
            MKScannerBXPSHallCountController *vc = [[MKScannerBXPSHallCountController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 4) {
        //T&H data sample rate
        id <MKScannerTHDataSampleRateProtocol>protocol = self.protocol.sampleRateProtocol;
        if (protocol) {
            MKScannerTHDataSampleRateController *vc = [[MKScannerTHDataSampleRateController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 5) {
        //Advertisement parameters
        id <MKScannerBXPSAdvParamsProtocol>protocol = self.protocol.advProtocol;
        if (protocol) {
            MKScannerBXPSAdvParamsController *vc = [[MKScannerBXPSAdvParamsController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 6) {
        //Remote reminder
        id <MKScannerBXPSReminderProtocol>protocol = self.protocol.remoteReminderProtocol;
        if (protocol) {
            MKScannerBXPSReminderController *vc = [[MKScannerBXPSReminderController alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
    if (indexPath.section == 3 && indexPath.row == 7) {
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
        MKScannerButtonFirmwareCell *cell = [MKScannerButtonFirmwareCell initCellWithTableView:tableView];
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

#pragma mark - MKScannerButtonFirmwareCellDelegate
- (void)mk_scanner_buttonFirmwareCell_buttonAction:(NSInteger)index {
    if (index == 0) {
        //DFU
        id <MKScannerButtonDfuV2Protocol>protocol = self.protocol.dfuProtocol;
        if (protocol) {
            protocol.type = 6;
            MKScannerButtonDfuV2Controller *vc = [[MKScannerButtonDfuV2Controller alloc] initWithProtocol:protocol];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [self.view showCentralToast:@"Protocol cannot be empty"];
        }
        return;
    }
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol readConnectedStatusWithSucBlock:^(id  _Nonnull returnData) {
        @strongify(self);
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            [self.view showCentralToast:@"Read Failed"];
            return;
        }
        self.bxpStatusDic = returnData;
        [self updateStatusDatas];
    }
                                       failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)disconnect {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol disconnectWithSucBlock:^(id  _Nonnull returnData) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.navigationController popViewControllerAnimated:YES];
    }
                              failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)powerOffCmdToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol powerOffWithSucBlock:^(id  _Nonnull returnData) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.navigationController popViewControllerAnimated:YES];
    }
                            failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)updateStatusDatas {
    MKNormalTextCellModel *cellModel1 = self.section2List[3];
    cellModel1.rightMsg = [NSString stringWithFormat:@"%@%@",self.bxpStatusDic[@"data"][@"battery_level"],@"%"];
    
    [self.tableView reloadData];
}

#pragma mark - private method
- (void)setupBlock {
    @weakify(self);
    self.protocol.receiveDisconnectBlock = ^{
        @strongify(self);
        [self receiveDisconnect];
    };
}

- (void)receiveDisconnect {
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_scanner_needDismissAlert" object:nil];
    //返回上一级页面
    [self.navigationController popViewControllerAnimated:YES];
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
                 notificationName:@"mk_scanner_needDismissAlert"];
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
    cellModel1.rightMsg = SafeStr(self.protocol.deviceBleInfo[@"data"][@"product_model"]);
    [self.section0List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Manufacture";
    cellModel2.rightMsg = SafeStr(self.protocol.deviceBleInfo[@"data"][@"company_name"]);
    [self.section0List addObject:cellModel2];
}

- (void)loadSection1Datas {
    MKScannerButtonFirmwareCellModel *cellModel = [[MKScannerButtonFirmwareCellModel alloc] init];
    cellModel.index = 0;
    cellModel.leftMsg = @"Firmware version";
    cellModel.rightMsg = SafeStr(self.protocol.deviceBleInfo[@"data"][@"firmware_version"]);
    cellModel.rightButtonTitle = @"DFU";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"Hardware version";
    cellModel1.rightMsg = SafeStr(self.protocol.deviceBleInfo[@"data"][@"hardware_version"]);
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Software version";
    cellModel2.rightMsg = SafeStr(self.protocol.deviceBleInfo[@"data"][@"software_version"]);
    [self.section2List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"MAC address";
    cellModel3.rightMsg = SafeStr(self.protocol.deviceBleInfo[@"data"][@"mac"]);
    [self.section2List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftMsg = @"Battery percent";
    cellModel4.rightMsg = @"";
    [self.section2List addObject:cellModel4];
    
    MKNormalTextCellModel *cellModel5 = [[MKNormalTextCellModel alloc] init];
    cellModel5.leftMsg = @"Sensor status";
        
    NSMutableArray *tempList = [NSMutableArray array];
    
    if ([self.protocol.deviceBleInfo[@"data"][@"axis_type"] integerValue] > 0) {
        [tempList addObject:@"ACC"];
    }
    
    if ([self.protocol.deviceBleInfo[@"data"][@"th_type"] integerValue] > 0) {
        [tempList addObject:@"TH"];
    }
    
    if ([self.protocol.deviceBleInfo[@"data"][@"light_type"] integerValue] > 0) {
        [tempList addObject:@"Light"];
    }
    
    if ([self.protocol.deviceBleInfo[@"data"][@"pir_type"] integerValue] > 0) {
        [tempList addObject:@"PIR"];
    }
    
    if ([self.protocol.deviceBleInfo[@"data"][@"tof_type"] integerValue] > 0) {
        [tempList addObject:@"TOF"];
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
    cellModel4.leftMsg = @"Hall sensor data";
    [self.section3List addObject:cellModel4];
    
    MKSettingTextCellModel *cellModel5 = [[MKSettingTextCellModel alloc] init];
    cellModel5.leftMsg = @"TH data sample rate";
    [self.section3List addObject:cellModel5];
    
    MKSettingTextCellModel *cellModel6 = [[MKSettingTextCellModel alloc] init];
    cellModel6.leftMsg = @"Advertisement parameters";
    [self.section3List addObject:cellModel6];
    
    MKSettingTextCellModel *cellModel7 = [[MKSettingTextCellModel alloc] init];
    cellModel7.leftMsg = @"Remote reminder";
    [self.section3List addObject:cellModel7];
    
    MKSettingTextCellModel *cellModel8 = [[MKSettingTextCellModel alloc] init];
    cellModel8.leftMsg = @"Power off";
    [self.section3List addObject:cellModel8];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = self.protocol.title;
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
