//
//  MKGWBXPButtonAccHeaderView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWBXPButtonAccHeaderViewDelegate <NSObject>

- (void)gw_bxpButtonAccHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gw_bxpButtonAccHeaderView_exportButtonPressed;

@end

@interface MKGWBXPButtonAccHeaderView : UIView

/// 是否显示底部的Timestamp和3-axis data标签，默认显示
@property (nonatomic, assign)BOOL showTimeLabel;

@property (nonatomic, weak)id <MKGWBXPButtonAccHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
