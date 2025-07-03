//
//  MKGWBXPCHistoricalTHDataHeaderView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/11.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWBXPCHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)gw_bxpcHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gw_bxpcHistoricalHTDataHeaderView_deleteButtonPressed;

- (void)gw_bxpcHistoricalHTDataHeaderView_exportButtonPressed;

@end

@interface MKGWBXPCHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKGWBXPCHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
