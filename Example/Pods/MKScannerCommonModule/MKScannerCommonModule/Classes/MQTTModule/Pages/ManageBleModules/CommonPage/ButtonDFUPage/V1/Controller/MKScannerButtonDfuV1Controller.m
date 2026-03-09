//
//  MKScannerButtonDfuV1Controller.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerButtonDfuV1Controller.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKTextFieldCell.h"

#import "MKHudManager.h"

@interface MKScannerButtonDfuV1Controller ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)id <MKScannerButtonDfuV1Protocol>protocol;

@property (nonatomic, strong)UILabel *progressLabel;

@property (nonatomic, assign)BOOL receiveComplete;

@end

@implementation MKScannerButtonDfuV1Controller

- (void)dealloc {
    NSLog(@"MKScannerButtonDfuV1Controller销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerButtonDfuV1Protocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
        [self setupBlocks];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
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
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    MKTextFieldCellModel *cellModel = self.dataList[index];
    cellModel.textFieldValue = value;
    if (index == 0) {
        //Firmware file URL
        self.protocol.firmwareUrl = value;
        return;
    }
    if (index == 1) {
        //Init data file URL
        self.protocol.dataUrl = value;
        return;
    }
}

#pragma mark - dfu

- (void)receiveDfuProgress:(NSString *)bleMac percent:(NSString *)percent {
    if (self.receiveComplete) {
        return;
    }
    [[MKHudManager share] hide];
    self.progressLabel.hidden = NO;
    self.progressLabel.text = [NSString stringWithFormat:@"Beacon DFU process: %@%@",percent,@"%"];
}

- (void)receiveDfuResult:(NSString *)bleMac resultCode:(NSInteger)resultCode {
    [[MKHudManager share] hide];
    self.receiveComplete = YES;
    self.progressLabel.hidden = YES;
    self.leftButton.enabled = YES;
    if (resultCode == 0) {
        [self.view showCentralToast:@"Beacon DFU successfully!"];
        [self performSelector:@selector(gotoLastPage) withObject:nil afterDelay:0.5f];
        return;
    }
    [self.view showCentralToast:@"Beacon DFU failed!"];
    [self performSelector:@selector(gotoLastPage) withObject:nil afterDelay:0.5f];
}

#pragma mark - event method
- (void)startButtonPressed {
    [self configDataToDevice];
}

#pragma mark - interface
- (void)configDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    @weakify(self);
    self.leftButton.enabled = NO;
    self.receiveComplete = NO;
    [self.protocol configDataWithSucBlock:^{
        
    }
                              failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        self.leftButton.enabled = YES;
        self.receiveComplete = YES;
    }];
}

#pragma mark - private method
- (void)setupBlocks {
    @weakify(self);
    self.protocol.receiveDfuProgressBlock = ^(NSString * _Nonnull gatewayMacAddress, NSString * _Nonnull deviceMacAddress, NSString * _Nonnull percent) {
        @strongify(self);
        [self receiveDfuProgress:deviceMacAddress percent:percent];
    };
    self.protocol.receiveDfuResultBlock = ^(NSString * _Nonnull gatewayMacAddress, NSString * _Nonnull deviceMacAddress, NSInteger resultCode) {
        @strongify(self);
        [self receiveDfuResult:deviceMacAddress resultCode:resultCode];
    };
    self.protocol.deviceDisconnectBlock = ^(NSString * _Nonnull gatewayMacAddress, NSString * _Nonnull deviceMacAddress) {
        @strongify(self);
        [self gotoLastPage];
    };
}

- (void)gotoLastPage {
    //返回上一级页面
    for (UIViewController *vc in self.navigationController.viewControllers) {
        NSString *className = NSStringFromClass([vc class]);
        
        if ([className containsString:@"ManageBleDevicesController"]) {
            // 如果类名包含 ManageBleDevicesController，跳转到这个页面
            [self popToViewControllerWithClassName:className];
            break;
        }
        
        if ([className containsString:@"DeviceDataController"]) {
            // 如果类名包含 DeviceDataController，跳转到这个页面
            [self popToViewControllerWithClassName:className];
            break;
        }
    }
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msgFont = MKFont(13.f);
    cellModel1.msg = @"Firmware file URL";
    cellModel1.textPlaceholder = @"1- 256 Characters";
    cellModel1.textFieldType = mk_normal;
    cellModel1.maxLength = 256;
    cellModel1.textFieldTextFont = MKFont(13.f);
    [self.dataList addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msgFont = MKFont(13.f);
    cellModel2.msg = @"Init data file URL";
    cellModel2.textPlaceholder = @"1- 256 Characters";
    cellModel2.textFieldType = mk_normal;
    cellModel2.maxLength = 256;
    cellModel2.textFieldTextFont = MKFont(13.f);
    [self.dataList addObject:cellModel2];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"DFU";
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
        
        _tableView.tableFooterView = [self tableFooterView];
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.backgroundColor = RGBACOLOR(33, 33, 33, 0.8);
        _progressLabel.textColor = COLOR_WHITE_MACROS;
        _progressLabel.font = MKFont(14.f);
        _progressLabel.numberOfLines = 0;
        
        _progressLabel.layer.masksToBounds = YES;
        _progressLabel.layer.cornerRadius = 6.f;
    }
    return _progressLabel;
}

- (UIView *)tableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 250.f)];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    [footerView addSubview:self.progressLabel];
    self.progressLabel.frame = CGRectMake((kViewWidth - 150.f) / 2, 50.f, 150.f, 60.f);
    self.progressLabel.hidden = YES;
    
    UIButton *startButton = [MKCustomUIAdopter customButtonWithTitle:@"Start Update"
                                                              target:self
                                                              action:@selector(startButtonPressed)];
    startButton.frame = CGRectMake((kViewWidth - 130.f) / 2, 120.f, 130.f, 40.f);
    [footerView addSubview:startButton];
    
    return footerView;
}

@end
