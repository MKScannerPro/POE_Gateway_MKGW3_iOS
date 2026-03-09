//
//  MKScannerBXPButtonAccHeaderView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPButtonAccHeaderViewDelegate <NSObject>

- (void)mk_scanner_bxpButtonAccHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)mk_scanner_bxpButtonAccHeaderView_exportButtonPressed;

@end

@interface MKScannerBXPButtonAccHeaderView : UIView

/// 是否显示底部的Timestamp和3-axis data标签，默认显示
@property (nonatomic, assign)BOOL showTimeLabel;

@property (nonatomic, weak)id <MKScannerBXPButtonAccHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
