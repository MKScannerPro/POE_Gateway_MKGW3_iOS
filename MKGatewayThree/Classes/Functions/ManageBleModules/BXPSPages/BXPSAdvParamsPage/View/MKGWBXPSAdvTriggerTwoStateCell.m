//
//  MKGWBXPSAdvTriggerTwoStateCell.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSAdvTriggerTwoStateCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKGWBXPSAdvTriggerTwoStateCellModel

- (CGFloat)fetchCellHeight {
    return 240.f;
}

@end

@interface MKGWBXPSAdvTriggerTwoStateCell ()

@property (nonatomic, strong)UILabel *slotLabel;

@property (nonatomic, strong)UILabel *beforeTriggerLabel;

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

@implementation MKGWBXPSAdvTriggerTwoStateCell

+ (MKGWBXPSAdvTriggerTwoStateCell *)initCellWithTableView:(UITableView *)tableView {
    MKGWBXPSAdvTriggerTwoStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGWBXPSAdvTriggerTwoStateCellIdenty"];
    if (!cell) {
        cell = [[MKGWBXPSAdvTriggerTwoStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWBXPSAdvTriggerTwoStateCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.slotLabel];
        [self.contentView addSubview:self.beforeTriggerLabel];
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
    [self.slotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.setBtn.mas_left).mas_offset(-10.f);
        make.centerY.mas_equalTo(self.setBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(35.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.beforeTriggerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.setBtn.mas_bottom);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.beforeAdvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.beforeIntervalField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.beforeUnitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.beforeIntervalField.mas_centerY);
        make.height.mas_equalTo(25.f);
    }];
    [self.beforeIntervalField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.beforeUnitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self.beforeTriggerLabel.mas_bottom).mas_offset(10.f);
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
    NSInteger beforeTxPower = 0;
    for (NSInteger i = 0; i < self.txPowerList.count; i ++) {
        if ([self.beforeTxPowerBtn.titleLabel.text isEqualToString:self.txPowerList[i]]) {
            beforeTxPower = i;
            break;
        }
    }
    NSInteger afterTxPower = 0;
    for (NSInteger i = 0; i < self.txPowerList.count; i ++) {
        if ([self.afterTxPowerBtn.titleLabel.text isEqualToString:self.txPowerList[i]]) {
            afterTxPower = i;
            break;
        }
    }
    if ([self.delegate respondsToSelector:@selector(gw_BXPSAdvTriggerTwoStateCell_setPressed:beforeInterval:beforeTxPower:afterInterval:afterTxPower:)]) {
        [self.delegate gw_BXPSAdvTriggerTwoStateCell_setPressed:self.dataModel.slotIndex
                                                 beforeInterval:SafeStr(self.beforeIntervalField.text)
                                                  beforeTxPower:beforeTxPower
                                                  afterInterval:SafeStr(self.afterIntervalField.text)
                                                   afterTxPower:afterTxPower];
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
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKGWBXPSAdvTriggerTwoStateCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGWBXPSAdvTriggerTwoStateCellModel.class]) {
        return;
    }
    self.slotLabel.text = [NSString stringWithFormat:@"Slot %ld",(long)(_dataModel.slotIndex + 1)];
    self.beforeTriggerLabel.text = [NSString stringWithFormat:@"ADV before triggered:%@",[self getSlotTypeString:_dataModel.beforeSlotType]];
    self.beforeIntervalField.text = SafeStr(_dataModel.beforeTriggerInterval);
    [self.beforeTxPowerBtn setTitle:self.txPowerList[_dataModel.beforeTriggerTxPower] forState:UIControlStateNormal];
    self.afterAdvLabel.text = [NSString stringWithFormat:@"ADV after triggered:%@",[self getSlotTypeString:_dataModel.afterSlotType]];
    self.afterIntervalField.text = SafeStr(_dataModel.afterTriggerInterval);
    [self.afterTxPowerBtn setTitle:self.txPowerList[_dataModel.afterTriggerTxPower] forState:UIControlStateNormal];
}

#pragma mark - private method
- (NSString *)getSlotTypeString:(MKGWBXPSAdvTriggerTwoStateCellSlotType)slotType {
    if (slotType == MKGWBXPSAdvTriggerTwoStateCellSlotTypeUID) {
        return @"UID";
    }
    if (slotType == MKGWBXPSAdvTriggerTwoStateCellSlotTypeURL) {
        return @"URL";
    }
    if (slotType == MKGWBXPSAdvTriggerTwoStateCellSlotTypeTLM) {
        return @"TLM";
    }
    if (slotType == MKGWBXPSAdvTriggerTwoStateCellSlotTypeBeacon) {
        return @"iBeacon";
    }
    if (slotType == MKGWBXPSAdvTriggerTwoStateCellSlotTypeTHInfo) {
        return @"T&H info";
    }
    if (slotType == MKGWBXPSAdvTriggerTwoStateCellSlotTypeSensorInfo) {
        return @"Sensor info";
    }
    
    return @"No data";
}

#pragma mark - getter
- (UILabel *)slotLabel {
    if (!_slotLabel) {
        _slotLabel = [[UILabel alloc] init];
        _slotLabel.textColor = DEFAULT_TEXT_COLOR;
        _slotLabel.textAlignment = NSTextAlignmentLeft;
        _slotLabel.font = MKFont(15.f);
    }
    return _slotLabel;
}

- (UILabel *)beforeTriggerLabel {
    if (!_beforeTriggerLabel) {
        _beforeTriggerLabel = [self loadLabelWithMsg:@""];
    }
    return _beforeTriggerLabel;
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
        _beforeAdvLabel = [self loadLabelWithMsg:@""];
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
        _afterAdvLabel = [self loadLabelWithMsg:@""];
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
