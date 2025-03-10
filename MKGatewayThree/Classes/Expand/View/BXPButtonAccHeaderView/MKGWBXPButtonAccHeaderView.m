//
//  MKGWBXPButtonAccHeaderView.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonAccHeaderView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@interface MKGWBXPButtonAccHeaderView ()

@property (nonatomic, strong)UIButton *syncButton;

@property (nonatomic, strong)UIImageView *synIcon;

@property (nonatomic, strong)UILabel *syncLabel;

@property (nonatomic, strong)UIButton *exportButton;

@property (nonatomic, strong)UILabel *exportLabel;

@property (nonatomic, strong)UILabel *timestampLabel;

@property (nonatomic, strong)UILabel *axisLabel;

@end

@implementation MKGWBXPButtonAccHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE_MACROS;
        [self addSubview:self.syncButton];
        [self.syncButton addSubview:self.synIcon];
        [self addSubview:self.syncLabel];
        [self addSubview:self.exportButton];
        [self addSubview:self.exportLabel];
        [self addSubview:self.timestampLabel];
        [self addSubview:self.axisLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.syncButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(15.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.synIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.syncButton.mas_centerX);
        make.centerY.mas_equalTo(self.syncButton.mas_centerY);
        make.width.mas_equalTo(25.f);
        make.height.mas_equalTo(25.f);
    }];
    [self.syncLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.syncButton.mas_left);
        make.right.mas_equalTo(self.syncButton.mas_right);
        make.top.mas_equalTo(self.syncButton.mas_bottom).mas_offset(2.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.exportButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.syncButton.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.exportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.exportButton.mas_left);
        make.right.mas_equalTo(self.exportButton.mas_right);
        make.top.mas_equalTo(self.exportButton.mas_bottom).mas_offset(2.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.width.mas_equalTo(120.f);
        make.top.mas_equalTo(self.syncLabel.mas_bottom).mas_offset(20.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.axisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timestampLabel.mas_right).mas_offset(30.f);
        make.width.mas_equalTo(130.f);
        make.centerY.mas_equalTo(self.timestampLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
}

#pragma mark - event method

- (void)syncButtonPressed {
    if ([self.delegate respondsToSelector:@selector(gw_bxpButtonAccHeaderView_syncButtonPressed)]) {
        [self.delegate gw_bxpButtonAccHeaderView_syncButtonPressed];
    }
}

- (void)exportButtonPressed {
    if ([self.delegate respondsToSelector:@selector(gw_bxpButtonAccHeaderView_exportButtonPressed)]) {
        [self.delegate gw_bxpButtonAccHeaderView_exportButtonPressed];
    }
}

- (void)setShowTimeLabel:(BOOL)showTimeLabel {
    self.timestampLabel.hidden = !showTimeLabel;
    self.axisLabel.hidden = !showTimeLabel;
}

#pragma mark - getter

- (UIButton *)syncButton {
    if (!_syncButton) {
        _syncButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_syncButton addTarget:self
                          action:@selector(syncButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _syncButton;
}

- (UIImageView *)synIcon {
    if (!_synIcon) {
        _synIcon = [[UIImageView alloc] init];
        _synIcon.image = LOADICON(@"MKGatewayThree", @"MKGWBXPButtonAccHeaderView", @"gw_threeAxisAcceLoadingIcon.png");
    }
    return _synIcon;
}

- (UILabel *)syncLabel {
    if (!_syncLabel) {
        _syncLabel = [[UILabel alloc] init];
        _syncLabel.textColor = DEFAULT_TEXT_COLOR;
        _syncLabel.textAlignment = NSTextAlignmentCenter;
        _syncLabel.font = MKFont(10.f);
        _syncLabel.text = @"Sync";
    }
    return _syncLabel;
}

- (UIButton *)exportButton {
    if (!_exportButton) {
        _exportButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exportButton setImage:LOADICON(@"MKGatewayThree", @"MKGWBXPButtonAccHeaderView", @"gw_slotExportEnableIcon.png") forState:UIControlStateNormal];
        [_exportButton addTarget:self
                          action:@selector(exportButtonPressed)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _exportButton;
}

- (UILabel *)exportLabel {
    if (!_exportLabel) {
        _exportLabel = [[UILabel alloc] init];
        _exportLabel.textColor = DEFAULT_TEXT_COLOR;
        _exportLabel.textAlignment = NSTextAlignmentCenter;
        _exportLabel.font = MKFont(10.f);
        _exportLabel.text = @"Export";
    }
    return _exportLabel;
}

- (UILabel *)timestampLabel {
    if (!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.textColor = DEFAULT_TEXT_COLOR;
        _timestampLabel.textAlignment = NSTextAlignmentCenter;
        _timestampLabel.font = MKFont(13.f);
        _timestampLabel.text = @"Timestamp";
    }
    return _timestampLabel;
}

- (UILabel *)axisLabel {
    if (!_axisLabel) {
        _axisLabel = [[UILabel alloc] init];
        _axisLabel.textColor = DEFAULT_TEXT_COLOR;
        _axisLabel.textAlignment = NSTextAlignmentCenter;
        _axisLabel.font = MKFont(13.f);
        _axisLabel.text = @"3-axis data";
    }
    return _axisLabel;
}

@end
