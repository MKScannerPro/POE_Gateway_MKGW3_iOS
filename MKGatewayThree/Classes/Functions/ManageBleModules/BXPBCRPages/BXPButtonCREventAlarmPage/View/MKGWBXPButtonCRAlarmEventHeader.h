//
//  MKGWBXPButtonCRAlarmEventHeader.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWBXPButtonCRAlarmEventHeaderDelegate <NSObject>

- (void)gw_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)gw_bxpButtonCRAlarmEventHeaderView_exportButtonPressed;

@end

@interface MKGWBXPButtonCRAlarmEventHeader : UIView

@property (nonatomic, weak)id <MKGWBXPButtonCRAlarmEventHeaderDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
