//
//  MKScannerManageBleDevicesTypeSelectedCell.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerManageBleDevicesTypeSelectedCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKScannerManageBleDevicesTypeSelectedCellModel
@end

@interface MKScannerManageBleDevicesTypeSelectedCell ()

@property (nonatomic, strong)UIControl *backControl;

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIImageView *selectedIcon;

@end

@implementation MKScannerManageBleDevicesTypeSelectedCell

+ (MKScannerManageBleDevicesTypeSelectedCell *)initCellWithTableView:(UITableView *)tableView {
    MKScannerManageBleDevicesTypeSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKScannerManageBleDevicesTypeSelectedCellIdenty"];
    if (!cell) {
        cell = [[MKScannerManageBleDevicesTypeSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKScannerManageBleDevicesTypeSelectedCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = COLOR_WHITE_MACROS;
        [self.contentView addSubview:self.backControl];
        [self.backControl addSubview:self.msgLabel];
        [self.backControl addSubview:self.selectedIcon];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.selectedIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.width.mas_equalTo(15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(15.f);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectedIcon.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-25.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(14.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)selectedCurrentCell {
    self.backControl.selected = !self.backControl.selected;
    self.selectedIcon.image = (self.backControl.selected ? LOADICON(@"MKScannerCommonModule", @"MKScannerManageBleDevicesTypeSelectedCell", @"mk_scanner_listButtonSelectedIcon.png") : LOADICON(@"MKScannerCommonModule", @"MKScannerManageBleDevicesTypeSelectedCell", @"mk_scanner_listButtonUnselectedIcon.png"));
    if ([self.delegate respondsToSelector:@selector(mk_scanner_manageBleDevicesTypeSelectedCell_selected:index:)]) {
        [self.delegate mk_scanner_manageBleDevicesTypeSelectedCell_selected:self.backControl.selected index:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKScannerManageBleDevicesTypeSelectedCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKScannerManageBleDevicesTypeSelectedCellModel.class]) {
        return;
    }
    self.selectedIcon.image = (_dataModel.selected ? LOADICON(@"MKScannerCommonModule", @"MKScannerManageBleDevicesTypeSelectedCell", @"mk_scanner_listButtonSelectedIcon.png") : LOADICON(@"MKScannerCommonModule", @"MKScannerManageBleDevicesTypeSelectedCell", @"mk_scanner_listButtonUnselectedIcon.png"));
    self.msgLabel.text = SafeStr(_dataModel.msg);
}

#pragma mark - getter
- (UIControl *)backControl {
    if (!_backControl) {
        _backControl = [[UIControl alloc] init];
        _backControl.backgroundColor = COLOR_WHITE_MACROS;
        [_backControl addTarget:self
                         action:@selector(selectedCurrentCell)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _backControl;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(14.f);
    }
    return _msgLabel;
}

- (UIImageView *)selectedIcon {
    if (!_selectedIcon) {
        _selectedIcon = [[UIImageView alloc] init];
    }
    return _selectedIcon;
}

@end
