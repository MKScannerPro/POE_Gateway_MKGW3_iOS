//
//  MKGWSystemTimeCell.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWSystemTimeCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKCustomUIAdopter.h"

@implementation MKGWSystemTimeCellModel
@end

@interface MKGWSystemTimeCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *rightButton;

@end

@implementation MKGWSystemTimeCell

+ (MKGWSystemTimeCell *)initCellWithTableView:(UITableView *)tableView {
    MKGWSystemTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGWSystemTimeCellIdenty"];
    if (!cell) {
        cell = [[MKGWSystemTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWSystemTimeCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.rightButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(35.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.rightButton.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)rightButtonPressed {
    if ([self.delegate respondsToSelector:@selector(gw_systemTimeButtonPressed:)]) {
        [self.delegate gw_systemTimeButtonPressed:self.dataModel.index];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKGWSystemTimeCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGWSystemTimeCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    [self.rightButton setTitle:SafeStr(_dataModel.buttonTitle) forState:UIControlStateNormal];
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

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [MKCustomUIAdopter customButtonWithTitle:@""
                                                         target:self
                                                         action:@selector(rightButtonPressed)];
    }
    return _rightButton;
}

@end
