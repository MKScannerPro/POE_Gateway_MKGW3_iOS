//
//  MKScannerResetByButtonController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerResetByButtonController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKHudManager.h"

#import "MKScannerResetByButtonCell.h"

@interface MKScannerResetByButtonController ()<UITableViewDelegate,
UITableViewDataSource,
MKScannerResetByButtonCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, assign)BOOL debugMode;

@property (nonatomic, strong)id <MKScannerResetByButtonProtocol>protocol;

@end

@implementation MKScannerResetByButtonController

- (void)dealloc {
    NSLog(@"MKScannerResetByButtonController销毁");
}

- (instancetype)initWithProtocol:(id<MKScannerResetByButtonProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef DEBUG
    self.debugMode = YES;
#endif
    [self loadSubViews];
    [self loadSectionDatas];
    [self readDataFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return (self.debugMode ? self.section0List.count : 0);
    }
    return self.section1List.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKScannerResetByButtonCell *cell = [MKScannerResetByButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKScannerResetByButtonCell *cell = [MKScannerResetByButtonCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKScannerResetByButtonCellDelegate
- (void)mk_scanner_resetByButtonCellAction:(NSInteger)index {
    self.protocol.type = index;
    
    [self configDataToDevice];
}

#pragma mark - Interface
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
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKScannerResetByButtonCellModel *cellModel = [[MKScannerResetByButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Disable";
    cellModel.selected = (index == 0);
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKScannerResetByButtonCellModel *cellModel1 = [[MKScannerResetByButtonCellModel alloc] init];
    cellModel1.index = 1;
    cellModel1.msg = @"Press in 1 minute after powered";
    cellModel1.selected = (index == 1);
    [self.section1List addObject:cellModel1];
    
    MKScannerResetByButtonCellModel *cellModel2 = [[MKScannerResetByButtonCellModel alloc] init];
    cellModel2.index = 2;
    cellModel2.msg = @"Press any time";
    cellModel2.selected = (index == 2);
    [self.section1List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Reset device by button";
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

@end
