//
//  MKScannerManageBleDevicesTypeSelectedView.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerManageBleDevicesTypeSelectedView.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKBaseTableView.h"

#import "MKScannerManageBleDevicesTypeSelectedCell.h"

static CGFloat const offset_X = 20.f;
static CGFloat const backViewHeight = 400.f;

@interface MKScannerManageBleDevicesTypeSelectedView ()<UIGestureRecognizerDelegate,
UITableViewDelegate,
UITableViewDataSource,
MKScannerManageBleDevicesTypeSelectedCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, copy)void (^selectedBlock)(MKScannerManageBleDevicesTypeSelectedViewType selectedType);

@property (nonatomic, assign)MKScannerManageBleDevicesTypeSelectedViewType selectedType;

@end

@implementation MKScannerManageBleDevicesTypeSelectedView

- (void)dealloc{
    NSLog(@"MKScannerManageBleDevicesTypeSelectedView销毁");
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = kAppWindow.bounds;
        [self setBackgroundColor:RGBACOLOR(0, 0, 0, 0.4f)];
        [self addSubview:self.tableView];
        [self addTapAction];
    }
    return self;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKScannerManageBleDevicesTypeSelectedCell *cell = [MKScannerManageBleDevicesTypeSelectedCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view != self) {
        return NO;
    }
    return YES;
}

#pragma mark - MKScannerManageBleDevicesTypeSelectedCellDelegate
- (void)mk_scanner_manageBleDevicesTypeSelectedCell_selected:(BOOL)selected index:(NSInteger)index {
    self.selectedType = index;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        MKScannerManageBleDevicesTypeSelectedCellModel *cellModel = self.dataList[i];
        cellModel.selected = (index == i);
    }
    [self.tableView reloadData];
}

#pragma mark - Private method

- (void)dismiss{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)confirmButtonPressed{
    if (self.selectedBlock) {
        self.selectedBlock(self.selectedType);
    }
    if (self.superview) {
        [self removeFromSuperview];
    }
}

- (void)addTapAction{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(dismiss)];
    [singleTap setNumberOfTouchesRequired:1];   //触摸点个数
    [singleTap setNumberOfTapsRequired:1];      //点击次数
    singleTap.delegate = self;
    [self addGestureRecognizer:singleTap];
}

#pragma mark - public method
+ (void)showWithType:(MKScannerManageBleDevicesTypeSelectedViewType)type
        selecteBlock:(void (^)(MKScannerManageBleDevicesTypeSelectedViewType selectedType))selecteBlock {
    MKScannerManageBleDevicesTypeSelectedView *view = [[MKScannerManageBleDevicesTypeSelectedView alloc] init];
    [view showWithType:type selecteBlock:selecteBlock];
}


#pragma mark - private method

- (void)showWithType:(MKScannerManageBleDevicesTypeSelectedViewType)type
        selecteBlock:(void (^)(MKScannerManageBleDevicesTypeSelectedViewType selectedType))selecteBlock {
    self.selectedType = type;
    [self loadSectionDatas];
    [kAppWindow addSubview:self];
    self.selectedBlock = selecteBlock;
    [self.tableView reloadData];
}

- (void)loadSectionDatas {
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel1 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.selected = (self.selectedType == 0);
    cellModel1.msg = @"BXP-B-D";
    [self.dataList addObject:cellModel1];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel2 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.selected = (self.selectedType == 1);
    cellModel2.msg = @"BXP-B-CR";
    [self.dataList addObject:cellModel2];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel3 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.selected = (self.selectedType == 2);
    cellModel3.msg = @"BXP-C";
    [self.dataList addObject:cellModel3];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel4 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.selected = (self.selectedType == 3);
    cellModel4.msg = @"BXP-D";
    [self.dataList addObject:cellModel4];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel5 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel5.index = 4;
    cellModel5.selected = (self.selectedType == 4);
    cellModel5.msg = @"BXP-T";
    [self.dataList addObject:cellModel5];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel6 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel6.index = 5;
    cellModel6.selected = (self.selectedType == 5);
    cellModel6.msg = @"BXP-S";
    [self.dataList addObject:cellModel6];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel7 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel7.index = 6;
    cellModel7.selected = (self.selectedType == 6);
    cellModel7.msg = @"MK PIR";
    [self.dataList addObject:cellModel7];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel8 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel8.index = 7;
    cellModel8.selected = (self.selectedType == 7);
    cellModel8.msg = @"MK TOF";
    [self.dataList addObject:cellModel8];
    
    MKScannerManageBleDevicesTypeSelectedCellModel *cellModel9 = [[MKScannerManageBleDevicesTypeSelectedCellModel alloc] init];
    cellModel9.index = 8;
    cellModel9.selected = (self.selectedType == 8);
    cellModel9.msg = @"Other";
    [self.dataList addObject:cellModel9];
}

#pragma mark - getter

- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectMake(offset_X,
                                                                       2 * kTopBarHeight,
                                                                       kViewWidth - 2 * offset_X,
                                                                       backViewHeight)
                                                      style:UITableViewStylePlain];
        _tableView.backgroundColor = COLOR_WHITE_MACROS;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = [self tableHeaderView];
        _tableView.tableFooterView = [self tableFootView];
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UIView *)tableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth - 2 * offset_X, 30.f)];
    headerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kViewWidth - 2 * offset_X - 20, 30.f)];
    titleLabel.textColor = DEFAULT_TEXT_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = MKFont(15.f);
    titleLabel.text = @"Beacon Type";
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (UIView *)tableFootView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth - 2 * offset_X, 100.f)];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(20.f, 50, 65.f, 35.f)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:NAVBAR_COLOR_MACROS forState:UIControlStateNormal];
    [cancelBtn addTarget:self
                  action:@selector(dismiss)
        forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(kViewWidth - 2 * offset_X - 20.f - 65.f, 50, 65.f, 30.f)];
    [confirmBtn setTitle:@"Confirm" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:NAVBAR_COLOR_MACROS forState:UIControlStateNormal];
    [confirmBtn addTarget:self
                   action:@selector(confirmButtonPressed)
         forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirmBtn];
    
    return footerView;
}

@end
