//
//  MKGWBXPSAdvTriggerCell.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSAdvTriggerCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKPickerView.h"

@implementation MKGWBXPSAdvTriggerCellModel

- (CGFloat)fetchCellHeight {
    if (self.slotType == MKGWBXPSAdvTriggerCellSlotTypeNoData) {
        return 44.f;
    }
    return 150.f;
}

@end


@interface MKGWBXPSAdvTriggerCell ()

@property (nonatomic, strong)UILabel *indexLabel;

@property (nonatomic, strong)UIButton *setBtn;

@property (nonatomic, strong)UILabel *slotTypeLabel;

@property (nonatomic, strong)UILabel *advLabel;

@property (nonatomic, strong)MKTextField *intervalField;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)UILabel *txPowerLabel;

@property (nonatomic, strong)UIButton *txPowerBtn;

@property (nonatomic, strong)NSArray *txPowerList;

@end

@implementation MKGWBXPSAdvTriggerCell

+ (MKGWBXPSAdvTriggerCell *)initCellWithTableView:(UITableView *)tableView {
    MKGWBXPSAdvTriggerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGWBXPSAdvTriggerCellIdenty"];
    if (!cell) {
        cell = [[MKGWBXPSAdvTriggerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWBXPSAdvTriggerCellIdenty"];
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
    if (self.dataModel.slotType == MKGWBXPSAdvTriggerCellSlotTypeNoData) {
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
    [self.slotTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
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
        make.top.mas_equalTo(self.slotTypeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.txPowerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(150.f);
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
    NSString *txPower = [self.txPowerBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"dBm" withString:@""];
    if ([self.delegate respondsToSelector:@selector(gw_BXPSAdvTriggerCell_setPressed:interval:txPower:)]) {
        [self.delegate gw_BXPSAdvTriggerCell_setPressed:self.dataModel.slotIndex
                                               interval:SafeStr(self.intervalField.text)
                                                txPower:[txPower integerValue]];
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
- (void)setDataModel:(MKGWBXPSAdvTriggerCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGWBXPSAdvTriggerCellModel.class]) {
        return;
    }
    if (self.setBtn.superview) {
        [self.setBtn removeFromSuperview];
    }
    if (self.slotTypeLabel.superview) {
        [self.slotTypeLabel removeFromSuperview];
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
    
    self.indexLabel.text = [NSString stringWithFormat:@"Slot %ld",(long)(_dataModel.slotIndex + 1)];
    
    if (_dataModel.slotType == MKGWBXPSAdvTriggerCellSlotTypeNoData) {
        self.indexLabel.text = [NSString stringWithFormat:@"Slot %ld:   No data",(long)(_dataModel.slotIndex + 1)];
        [self setNeedsLayout];
        return;
    }
    [self.contentView addSubview:self.setBtn];
    [self.contentView addSubview:self.slotTypeLabel];
    [self.contentView addSubview:self.advLabel];
    [self.contentView addSubview:self.intervalField];
    [self.contentView addSubview:self.unitLabel];
    [self.contentView addSubview:self.txPowerLabel];
    [self.contentView addSubview:self.txPowerBtn];
    self.slotTypeLabel.text = [NSString stringWithFormat:@"ADV after triggered:%@",[self getSlotTypeString:_dataModel.slotType]];
    self.intervalField.text = SafeStr(_dataModel.advInterval);
    [self.txPowerBtn setTitle:self.txPowerList[_dataModel.txPower] forState:UIControlStateNormal];
    [self setNeedsLayout];
}

#pragma mark - private method
- (NSString *)getSlotTypeString:(MKGWBXPSAdvTriggerCellSlotType)slotType {
    if (slotType == MKGWBXPSAdvTriggerCellSlotTypeUID) {
        return @"UID";
    }
    if (slotType == MKGWBXPSAdvTriggerCellSlotTypeURL) {
        return @"URL";
    }
    if (slotType == MKGWBXPSAdvTriggerCellSlotTypeTLM) {
        return @"TLM";
    }
    if (slotType == MKGWBXPSAdvTriggerCellSlotTypeBeacon) {
        return @"iBeacon";
    }
    if (slotType == MKGWBXPSAdvTriggerCellSlotTypeSensorInfo) {
        return @"Sensor info";
    }
    if (slotType == MKGWBXPSAdvTriggerCellSlotTypeTHInfo) {
        return @"T&H info";
    }
    
    return @"No data";
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

- (UILabel *)slotTypeLabel {
    if (!_slotTypeLabel) {
        _slotTypeLabel = [self loadLabelWithMsg:@""];
    }
    return _slotTypeLabel;
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
        _advLabel = [self loadLabelWithMsg:@"ADV interval after triggered"];
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
        _txPowerLabel = [self loadLabelWithMsg:@"Tx Power after triggered"];
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
        _txPowerList = @[@"-20dBm",@"-16dBm",@"-12dBm",@"-8dBm",@"-4dBm",@"0dBm",@"3dBm",@"4dBm",@"6dBm"];
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
