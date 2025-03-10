//
//  MKGWNetworkSsidSettingsCell.m
//  MKGatewayThree_Example
//
//  Created by aa on 2024/9/1.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKGWNetworkSsidSettingsCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCustomUIAdopter.h"
#import "MKTextField.h"


@implementation MKGWNetworkSsidSettingsCellModel
@end

@interface MKGWNetworkSsidSettingsCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UIButton *searchButton;

@end

@implementation MKGWNetworkSsidSettingsCell

+ (MKGWNetworkSsidSettingsCell *)initCellWithTableView:(UITableView *)tableView {
    MKGWNetworkSsidSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKGWNetworkSsidSettingsCellIdenty"];
    if (!cell) {
        cell = [[MKGWNetworkSsidSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKGWNetworkSsidSettingsCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.searchButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(90.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.searchButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.msgLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(self.searchButton.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)searchButtonPressed {
    if ([self.delegate respondsToSelector:@selector(gw_networkSsidSettingsCell_buttonPressed)]) {
        [self.delegate gw_networkSsidSettingsCell_buttonPressed];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKGWNetworkSsidSettingsCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKGWNetworkSsidSettingsCellModel.class]) {
        return;
    }
    self.textField.text = SafeStr(_dataModel.ssid);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"SSID";
    }
    return _msgLabel;
}

- (UIButton *)searchButton {
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setImage:LOADICON(@"MKGatewayThree", @"MKGWNetworkSsidSettingsCell", @"gw_searchGrayIcon.png") forState:UIControlStateNormal];
        [_searchButton addTarget:self
                          action:@selector(searchButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@""
                                                          placeHolder:@"1-32 Characters"
                                                             textType:mk_normal];
        _textField.maxLength = 32;
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(gw_networkSsidSettingsCell_ssidChanged:)]) {
                [self.delegate gw_networkSsidSettingsCell_ssidChanged:text];
            }
        };
    }
    return _textField;
}

@end
