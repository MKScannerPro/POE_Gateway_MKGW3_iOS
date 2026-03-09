//
//  MKScannerBXPAdvParamsCell.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKScannerBXPAdvParamsCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKScannerBXPAdvParamsCellModel

- (CGFloat)fetchCellHeight {
    if (self.slotType == MKScannerBXPAdvParamsCellSlotTypeNoData) {
        return 44.f;
    }
    return 150.f;
}

@end


@interface MKScannerBXPAdvParamsCell ()

@property (nonatomic, strong)UILabel *indexLabel;

@property (nonatomic, strong)UIButton *setBtn;

@property (nonatomic, strong)UILabel *triggerLabel;

@property (nonatomic, strong)UILabel *advLabel;

@property (nonatomic, strong)MKTextField *intervalField;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)UILabel *txPowerLabel;

@property (nonatomic, strong)UIButton *txPowerBtn;

@property (nonatomic, strong)NSArray *txPowerList;

@end

@implementation MKScannerBXPAdvParamsCell

+ (MKScannerBXPAdvParamsCell *)initCellWithTableView:(UITableView *)tableView {
    MKScannerBXPAdvParamsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKScannerBXPAdvParamsCellIdenty"];
    if (!cell) {
        cell = [[MKScannerBXPAdvParamsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKScannerBXPAdvParamsCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.indexLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.dataModel.slotType == MKScannerBXPAdvParamsCellSlotTypeNoData) {
        [self.indexLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15.f);
            make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5.f);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(MKFont(15.f).lineHeight);
        }];
        return;
    }
    [self.indexLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.contentView.mas_centerX).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.setBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.setBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(35.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.triggerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.setBtn.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.advLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.intervalField.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.intervalField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.unitLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.intervalField.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.intervalField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(80.f);
        make.top.mas_equalTo(self.triggerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.txPowerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.txPowerBtn.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.txPowerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
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
    if ([self.delegate respondsToSelector:@selector(mk_scanner_BXPAdvParamsCell_setPressedWithSlotIndex:interval:txPower:)]) {
        [self.delegate mk_scanner_BXPAdvParamsCell_setPressedWithSlotIndex:self.dataModel.slotIndex
                                                          interval:SafeStr(self.intervalField.text)
                                                           txPower:txPower];
    }
}

- (void)txPowerButtonPressed {
    [self.intervalField resignFirstResponder];
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
- (void)setDataModel:(MKScannerBXPAdvParamsCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKScannerBXPAdvParamsCellModel.class]) {
        return;
    }
    if (self.setBtn.superview) {
        [self.setBtn removeFromSuperview];
    }
    if (self.triggerLabel.superview) {
        [self.triggerLabel removeFromSuperview];
    }
    if (self.advLabel.superview) {
        [self.advLabel removeFromSuperview];
    }
    if (self.intervalField.superview) {
        [self.intervalField removeFromSuperview];
    }
    if (self.unitLabel.superview) {
        [self.unitLabel removeFromSuperview];
    }
    if (self.txPowerLabel.superview) {
        [self.txPowerLabel removeFromSuperview];
    }
    if (self.txPowerBtn.superview) {
        [self.txPowerBtn removeFromSuperview];
    }
    
    self.indexLabel.text = [NSString stringWithFormat:@"Slot %ld: %@",(long)(_dataModel.slotIndex + 1),[self getSlotTypeString:_dataModel.slotType]];
    
    if (_dataModel.slotType == MKScannerBXPAdvParamsCellSlotTypeNoData) {
        [self setNeedsLayout];
        return;
    }
    [self.contentView addSubview:self.setBtn];
    [self.contentView addSubview:self.triggerLabel];
    [self.contentView addSubview:self.advLabel];
    [self.contentView addSubview:self.intervalField];
    [self.contentView addSubview:self.unitLabel];
    [self.contentView addSubview:self.txPowerLabel];
    [self.contentView addSubview:self.txPowerBtn];
    
    if (_dataModel.bxpTag) {
        self.txPowerList = @[@"-20dBm",@"-16dBm",@"-12dBm",@"-8dBm",@"-4dBm",@"0dBm",@"3dBm",@"4dBm",@"6dBm"];
    }else {
        self.txPowerList = @[@"-40dBm",@"-20dBm",@"-16dBm",@"-12dBm",@"-8dBm",@"-4dBm",@"0dBm",@"3dBm",@"4dBm"];
    }
    
    self.triggerLabel.text = [NSString stringWithFormat:@"Trigger type:%@",[self getTriggerTypeString:_dataModel.triggerType]];
    self.intervalField.text = SafeStr(_dataModel.interval);
    [self.txPowerBtn setTitle:self.txPowerList[_dataModel.txPower] forState:UIControlStateNormal];
    [self setNeedsLayout];
}

#pragma mark - private method

- (NSString *)getSlotTypeString:(MKScannerBXPAdvParamsCellSlotType)slotType {
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeUID) {
        return @"UID";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeURL) {
        return @"URL";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeTLM) {
        return @"TLM";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeEID) {
        return @"EID";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeDeviceInfo) {
        return @"Device info";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeiBeacon) {
        return @"iBeacon";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeAccelerometer) {
        return @"ACC";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeHT) {
        return @"TH";
    }
    if (slotType == MKScannerBXPAdvParamsCellSlotTypeTag) {
        return @"Tag";
    }
    if (slotType == MKScannerBXPAdvParamsCellTriggerTypeSingleClick) {
        return @"Single click button";
    }
    return @"No data";
}

- (NSString *)getTriggerTypeString:(MKScannerBXPAdvParamsCellTriggerType)triggerType {
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeNull) {
        return @"Off";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeTemperature) {
        return @"Temperature";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeHumidity) {
        return @"Humidity";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeDoubleClick) {
        return @"Double click button";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeTripleClick) {
        return @"Triple click button";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeMove) {
        return @"Devices moves";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeLight) {
        return @"Light";
    }
    if (triggerType == MKScannerBXPAdvParamsCellTriggerTypeSingleClick) {
        return @"Single click button";
    }
    return @"";
}

#pragma mark - getter
- (UILabel *)indexLabel {
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.textColor = DEFAULT_TEXT_COLOR;
        _indexLabel.textAlignment = NSTextAlignmentLeft;
        _indexLabel.font = MKFont(15.f);
    }
    return _indexLabel;
}

- (UILabel *)triggerLabel {
    if (!_triggerLabel) {
        _triggerLabel = [self loadLabelWithMsg:@""];
    }
    return _triggerLabel;
}

- (UIButton *)setBtn {
    if (!_setBtn) {
        _setBtn = [MKCustomUIAdopter customButtonWithTitle:@"Set"
                                                    target:self
                                                    action:@selector(setButtonPressed)];
    }
    return _setBtn;
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
        _unitLabel.text = @"x 100ms";
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

- (UILabel *)loadLabelWithMsg:(NSString *)msg {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    label.text = msg;
    return label;
}

@end
