//
//  MKScannerPressEventCountCell.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKScannerPressEventCountCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKScannerPressEventCountCellModel
@end

@interface MKScannerPressEventCountCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *eventCountLabel;

@property (nonatomic, strong)UIButton *clearButton;

@end

@implementation MKScannerPressEventCountCell

+ (MKScannerPressEventCountCell *)initCellWithTableView:(UITableView *)tableView {
    MKScannerPressEventCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKScannerPressEventCountCellIdenty"];
    if (!cell) {
        cell = [[MKScannerPressEventCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKScannerPressEventCountCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.eventCountLabel];
        [self.contentView addSubview:self.clearButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.eventCountLabel.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.eventCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.clearButton.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.clearButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(45.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)clearButtonPressed {
    if ([self.delegate respondsToSelector:@selector(mk_scanner_pressEventCountCell_clearButtonPressed:)]) {
        [self.delegate mk_scanner_pressEventCountCell_clearButtonPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKScannerPressEventCountCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKScannerPressEventCountCellModel.class]) {
        return;
    }
    self.eventCountLabel.text = SafeStr(_dataModel.count);
    self.msgLabel.text = SafeStr(_dataModel.msg);
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

- (UILabel *)eventCountLabel {
    if (!_eventCountLabel) {
        _eventCountLabel = [[UILabel alloc] init];
        _eventCountLabel.textColor = DEFAULT_TEXT_COLOR;
        _eventCountLabel.textAlignment = NSTextAlignmentCenter;
        _eventCountLabel.font = MKFont(13.f);
        _eventCountLabel.text = @"0";
    }
    return _eventCountLabel;
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [MKCustomUIAdopter customButtonWithTitle:@"clear"
                                                         target:self
                                                         action:@selector(clearButtonPressed)];
    }
    return _clearButton;
}

@end
