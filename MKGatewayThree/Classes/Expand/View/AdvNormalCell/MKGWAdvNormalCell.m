//
//  MKGWAdvNormalCell.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWAdvNormalCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKGWAdvNormalCellModel
@end

@interface MKGWAdvNormalCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *statusLabel;

@property (nonatomic, strong)UIButton *setBtn;

@property (nonatomic, strong)UILabel *normalAdvLabel;

@property (nonatomic, strong)UILabel *advLabel;

@property (nonatomic, strong)MKTextField *intervalField;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)UILabel *txPowerLabel;

@property (nonatomic, strong)UIButton *txPowerBtn;

@property (nonatomic, strong)NSArray *txPowerList;

@end

@implementation MKGWAdvNormalCell

+ (MKGWAdvNormalCell *)initCellWithTableView:(UITableView *)tableView {
    MKGWAdvNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGWAdvNormalCellIdenty"];
    if (!cell) {
        cell = [[MKGWAdvNormalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWAdvNormalCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.setBtn];
        [self.contentView addSubview:self.normalAdvLabel];
        [self.contentView addSubview:self.advLabel];
        [self.contentView addSubview:self.intervalField];
        [self.contentView addSubview:self.unitLabel];
        [self.contentView addSubview:self.txPowerLabel];
        [self.contentView addSubview:self.txPowerBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.statusLabel.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.setBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(35.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.setBtn.mas_left).mas_offset(-10.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.setBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.normalAdvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.setBtn.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.top.mas_equalTo(self.normalAdvLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.intervalField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self.unitLabel.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.advLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.intervalField.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.intervalField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.txPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.txPowerBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.txPowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.top.mas_equalTo(self.intervalField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
}

#pragma mark - event method
- (void)setButtonPressed {
    NSInteger txPower = 0;
    for (NSInteger i = 0; i < self.txPowerList.count; i ++) {
        if ([self.txPowerBtn.titleLabel.text isEqualToString:self.txPowerList[i]]) {
            txPower = i;
            break;
        }
    }
    if ([self.delegate respondsToSelector:@selector(gw_advNormalCell_setPressed:interval:txPower:)]) {
        [self.delegate gw_advNormalCell_setPressed:self.dataModel.index
                                          interval:SafeStr(self.intervalField.text)
                                           txPower:txPower];
    }
}

- (void)txPowerButtonPressed {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.txPowerList.count; i ++) {
        if ([self.txPowerBtn.titleLabel.text isEqualToString:self.txPowerList[i]]) {
            index = i;
            break;
        }
    }
    MKPickerView *pickView = [[MKPickerView alloc] init];
    [pickView showPickViewWithDataList:self.txPowerList selectedRow:index block:^(NSInteger currentRow) {
        [self.txPowerBtn setTitle:self.txPowerList[currentRow] forState:UIControlStateNormal];
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKGWAdvNormalCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGWAdvNormalCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.intervalField.text = SafeStr(_dataModel.advInterval);
    [self.txPowerBtn setTitle:self.txPowerList[_dataModel.txPower] forState:UIControlStateNormal];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [self loadLabelWithMsg:@"ON"];
    }
    return _statusLabel;
}

- (UIButton *)setBtn {
    if (!_setBtn) {
        _setBtn = [MKCustomUIAdopter customButtonWithTitle:@"Set"
                                                    target:self
                                                    action:@selector(setButtonPressed)];
    }
    return _setBtn;
}

- (UILabel *)normalAdvLabel {
    if (!_normalAdvLabel) {
        _normalAdvLabel = [self loadLabelWithMsg:@"Normal ADV"];
    }
    return _normalAdvLabel;
}

- (UILabel *)advLabel {
    if (!_advLabel) {
        _advLabel = [self loadLabelWithMsg:@"ADV interval"];
    }
    return _advLabel;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.font = MKFont(12.f);
        _unitLabel.text = @"x 20ms";
    }
    return _unitLabel;
}

- (MKTextField *)intervalField {
    if (!_intervalField) {
        _intervalField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                              placeHolder:@"1-100"
                                                                 textType:mk_realNumberOnly];
        _intervalField.maxLength = 3;
    }
    return _intervalField;
}

- (UILabel *)txPowerLabel {
    if (!_txPowerLabel) {
        _txPowerLabel = [self loadLabelWithMsg:@"Tx Power"];
    }
    return _txPowerLabel;
}

- (UIButton *)txPowerBtn {
    if (!_txPowerBtn) {
        _txPowerBtn = [MKCustomUIAdopter customButtonWithTitle:@"0dBm"
                                                        target:self
                                                        action:@selector(txPowerButtonPressed)];
    }
    return _txPowerBtn;
}

- (NSArray *)txPowerList {
    if (!_txPowerList) {
        _txPowerList = @[@"-40dBm",@"-20dBm",@"-16dBm",@"-12dBm",@"-8dBm",@"-4dBm",@"0dBm",@"3dBm",@"4dBm"];
    }
    return _txPowerList;
}

- (UILabel *)loadLabelWithMsg:(NSString *)msg {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    label.text = msg;
    return label;
}

@end
