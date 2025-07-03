//
//  MKGWBXPSHistoricalTHDataHeaderView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/11.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWBXPSHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)gw_BXPSHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gw_BXPSHistoricalHTDataHeaderView_deleteButtonPressed;

- (void)gw_BXPSHistoricalHTDataHeaderView_exportButtonPressed;

@end

@interface MKGWBXPSHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKGWBXPSHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
