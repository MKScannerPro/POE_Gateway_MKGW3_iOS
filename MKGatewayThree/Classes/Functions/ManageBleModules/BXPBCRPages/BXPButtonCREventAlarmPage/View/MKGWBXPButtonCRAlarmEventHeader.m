//
//  MKGWBXPButtonCRAlarmEventHeader.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRAlarmEventHeader.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@interface MKGWBXPButtonCRAlarmEventHeader ()

@property (nonatomic, strong)UIButton *syncButton;

@property (nonatomic, strong)UIImageView *synIcon;

@property (nonatomic, strong)UILabel *syncLabel;

@property (nonatomic, strong)UIButton *exportButton;

@property (nonatomic, strong)UILabel *exportLabel;

@property (nonatomic, strong)UILabel *timestampLabel;

@property (nonatomic, strong)UILabel *axisLabel;

@end

@implementation MKGWBXPButtonCRAlarmEventHeader

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
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.axisLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timestampLabel.mas_right).mas_offset(30.f);
        make.width.mas_equalTo(130.f);
        make.centerY.mas_equalTo(self.timestampLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - event method

- (void)syncButtonPressed {
    if ([self.delegate respondsToSelector:@selector(gw_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:)]) {
        [self.delegate gw_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:!self.syncButton.selected];
    }
}

- (void)exportButtonPressed {
    if ([self.delegate respondsToSelector:@selector(gw_bxpButtonCRAlarmEventHeaderView_exportButtonPressed)]) {
        [self.delegate gw_bxpButtonCRAlarmEventHeaderView_exportButtonPressed];
    }
}

#pragma mark - public method
- (void)updateSyncStatus:(BOOL)isOn {
    [self.synIcon.layer removeAnimationForKey:@"mk_gw_syncAnimation"];
    self.syncButton.selected = isOn;
    if (isOn) {
        [self.synIcon.layer addAnimation:[MKCustomUIAdopter refreshAnimation:1.f]
                                   forKey:@"mk_gw_syncAnimation"];
        self.syncLabel.text = @"Stop";
    }else {
        self.syncLabel.text = @"Sync";
    }
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
        _synIcon.image = LOADICON(@"MKGatewayThree", @"MKGWBXPButtonCRAlarmEventHeader", @"gw_threeAxisAcceLoadingIcon.png");
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
        [_exportButton setImage:LOADICON(@"MKGatewayThree", @"MKGWBXPButtonCRAlarmEventHeader", @"gw_slotExportEnableIcon.png") forState:UIControlStateNormal];
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
        _axisLabel.text = @"Trigger mode";
    }
    return _axisLabel;
}

@end
