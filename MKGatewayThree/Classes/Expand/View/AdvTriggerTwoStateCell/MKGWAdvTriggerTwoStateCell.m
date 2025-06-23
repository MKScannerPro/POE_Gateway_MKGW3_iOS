//
//  MKGWAdvTriggerTwoStateCell.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWAdvTriggerTwoStateCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKGWAdvTriggerTwoStateCellModel
@end

@interface MKGWAdvTriggerTwoStateCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *statusLabel;

@property (nonatomic, strong)UIButton *setBtn;

@property (nonatomic, strong)UILabel *beforeAdvLabel;

@property (nonatomic, strong)UILabel *beforeAdvIntervalLabel;

@property (nonatomic, strong)MKTextField *beforeIntervalField;

@property (nonatomic, strong)UILabel *beforeUnitLabel;

@property (nonatomic, strong)UILabel *beforeTxPowerLabel;

@property (nonatomic, strong)UIButton *beforeTxPowerBtn;

@property (nonatomic, strong)UILabel *afterAdvLabel;

@property (nonatomic, strong)UILabel *afterAdvIntervalLabel;

@property (nonatomic, strong)MKTextField *afterIntervalField;

@property (nonatomic, strong)UILabel *afterUnitLabel;

@property (nonatomic, strong)UILabel *afterTxPowerLabel;

@property (nonatomic, strong)UIButton *afterTxPowerBtn;

@property (nonatomic, strong)NSArray *txPowerList;

@end

@implementation MKGWAdvTriggerTwoStateCell

+ (MKGWAdvTriggerTwoStateCell *)initCellWithTableView:(UITableView *)tableView {
    MKGWAdvTriggerTwoStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGWAdvTriggerTwoStateCellIdenty"];
    if (!cell) {
        cell = [[MKGWAdvTriggerTwoStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWAdvTriggerTwoStateCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.statusLabel];
        [self.contentView addSubview:self.setBtn];
        [self.contentView addSubview:self.beforeAdvLabel];
        [self.contentView addSubview:self.beforeAdvIntervalLabel];
        [self.contentView addSubview:self.beforeIntervalField];
        [self.contentView addSubview:self.beforeUnitLabel];
        [self.contentView addSubview:self.beforeTxPowerLabel];
        [self.contentView addSubview:self.beforeTxPowerBtn];
        [self.contentView addSubview:self.afterAdvLabel];
        [self.contentView addSubview:self.afterAdvIntervalLabel];
        [self.contentView addSubview:self.afterIntervalField];
        [self.contentView addSubview:self.afterUnitLabel];
        [self.contentView addSubview:self.afterTxPowerLabel];
        [self.contentView addSubview:self.afterTxPowerBtn];
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
    [self.beforeAdvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.setBtn.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.beforeUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.top.mas_equalTo(self.beforeAdvLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.beforeIntervalField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.beforeUnitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self.beforeUnitLabel.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.beforeAdvIntervalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.beforeIntervalField.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.beforeIntervalField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.beforeTxPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.beforeTxPowerBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.beforeTxPowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.top.mas_equalTo(self.beforeIntervalField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.afterAdvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.beforeTxPowerBtn.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.afterUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.top.mas_equalTo(self.afterAdvLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.afterIntervalField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.afterUnitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self.afterUnitLabel.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.afterAdvIntervalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.afterIntervalField.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.afterIntervalField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.afterTxPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.afterTxPowerBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.afterTxPowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.top.mas_equalTo(self.afterIntervalField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
}

#pragma mark - event method
- (void)setButtonPressed {
    NSString *beforeTxPower = [self.beforeTxPowerBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"dBm" withString:@""];
    NSString *afterTxPower = [self.afterTxPowerBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"dBm" withString:@""];
    if ([self.delegate respondsToSelector:@selector(gw_advNormalCell_setPressed:beforeInterval:beforeTxPower:afterInterval:afterTxPower:)]) {
        [self.delegate gw_advNormalCell_setPressed:self.dataModel.index
                                    beforeInterval:SafeStr(self.beforeIntervalField.text)
                                     beforeTxPower:[beforeTxPower integerValue]
                                     afterInterval:SafeStr(self.afterIntervalField.text)
                                      afterTxPower:[afterTxPower integerValue]];
    }
}

- (void)txPowerButtonPressed:(UIButton *)btn {
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.txPowerList.count; i ++) {
        if ([btn.titleLabel.text isEqualToString:self.txPowerList[i]]) {
            index = i;
            break;
        }
    }
    MKPickerView *pickView = [[MKPickerView alloc] init];
    [pickView showPickViewWithDataList:self.txPowerList selectedRow:index block:^(NSInteger currentRow) {
        [btn setTitle:self.txPowerList[currentRow] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(gw_advNormalCell_txPowerChanged:before:txPower:)]) {
        }
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKGWAdvTriggerTwoStateCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGWAdvTriggerTwoStateCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.beforeIntervalField.text = SafeStr(_dataModel.beforeTriggerInterval);
    [self.beforeTxPowerBtn setTitle:self.txPowerList[_dataModel.beforeTriggerTxPower] forState:UIControlStateNormal];
    self.afterIntervalField.text = SafeStr(_dataModel.afterTriggerInterval);
    [self.afterTxPowerBtn setTitle:self.txPowerList[_dataModel.afterTriggerTxPower] forState:UIControlStateNormal];
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

- (UILabel *)beforeAdvLabel {
    if (!_beforeAdvLabel) {
        _beforeAdvLabel = [self loadLabelWithMsg:@"ADV before triggered"];
    }
    return _beforeAdvLabel;
}

- (UILabel *)beforeAdvIntervalLabel {
    if (!_beforeAdvIntervalLabel) {
        _beforeAdvIntervalLabel = [self loadLabelWithMsg:@"ADV interval"];
    }
    return _beforeAdvIntervalLabel;
}

- (UILabel *)beforeUnitLabel {
    if (!_beforeUnitLabel) {
        _beforeUnitLabel = [[UILabel alloc] init];
        _beforeUnitLabel.textColor = DEFAULT_TEXT_COLOR;
        _beforeUnitLabel.textAlignment = NSTextAlignmentRight;
        _beforeUnitLabel.font = MKFont(12.f);
        _beforeUnitLabel.text = @"x 20ms";
    }
    return _beforeUnitLabel;
}

- (MKTextField *)beforeIntervalField {
    if (!_beforeIntervalField) {
        _beforeIntervalField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                              placeHolder:@"1-100"
                                                                 textType:mk_realNumberOnly];
        _beforeIntervalField.maxLength = 3;
    }
    return _beforeIntervalField;
}

- (UILabel *)beforeTxPowerLabel {
    if (!_beforeTxPowerLabel) {
        _beforeTxPowerLabel = [self loadLabelWithMsg:@"Tx Power"];
    }
    return _beforeTxPowerLabel;
}

- (UIButton *)beforeTxPowerBtn {
    if (!_beforeTxPowerBtn) {
        _beforeTxPowerBtn = [MKCustomUIAdopter customButtonWithTitle:@"0dBm"
                                                              target:self
                                                              action:@selector(txPowerButtonPressed:)];
    }
    return _beforeTxPowerBtn;
}

- (UILabel *)afterAdvLabel {
    if (!_afterAdvLabel) {
        _afterAdvLabel = [self loadLabelWithMsg:@"ADV after triggered"];
    }
    return _afterAdvLabel;
}

- (UILabel *)afterAdvIntervalLabel {
    if (!_afterAdvIntervalLabel) {
        _afterAdvIntervalLabel = [self loadLabelWithMsg:@"ADV interval"];
    }
    return _afterAdvIntervalLabel;
}

- (UILabel *)afterUnitLabel {
    if (!_afterUnitLabel) {
        _afterUnitLabel = [[UILabel alloc] init];
        _afterUnitLabel.textColor = DEFAULT_TEXT_COLOR;
        _afterUnitLabel.textAlignment = NSTextAlignmentRight;
        _afterUnitLabel.font = MKFont(12.f);
        _afterUnitLabel.text = @"x 20ms";
    }
    return _afterUnitLabel;
}

- (MKTextField *)afterIntervalField {
    if (!_afterIntervalField) {
        _afterIntervalField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                                   placeHolder:@"1-100"
                                                                      textType:mk_realNumberOnly];
        _afterIntervalField.maxLength = 3;
    }
    return _afterIntervalField;
}

- (UILabel *)afterTxPowerLabel {
    if (!_afterTxPowerLabel) {
        _afterTxPowerLabel = [self loadLabelWithMsg:@"Tx Power"];
    }
    return _afterTxPowerLabel;
}

- (UIButton *)afterTxPowerBtn {
    if (!_afterTxPowerBtn) {
        _afterTxPowerBtn = [MKCustomUIAdopter customButtonWithTitle:@"0dBm"
                                                             target:self
                                                             action:@selector(txPowerButtonPressed:)];
    }
    return _afterTxPowerBtn;
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
