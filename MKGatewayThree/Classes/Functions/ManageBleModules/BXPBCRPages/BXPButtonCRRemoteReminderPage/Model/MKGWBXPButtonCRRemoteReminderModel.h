//
//  MKGWBXPButtonCRRemoteReminderModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPButtonCRRemoteReminderModel : NSObject

#pragma mark - LED notification
@property (nonatomic, copy)NSString *blinkingTime;

@property (nonatomic, copy)NSString *blinkingInterval;

#pragma mark - Buzzer notification
@property (nonatomic, copy)NSString *ringingTime;

@property (nonatomic, copy)NSString *ringingInterval;

#pragma mark - Vibration notification
@property (nonatomic, copy)NSString *vibrationTime;

@property (nonatomic, copy)NSString *vibrationInterval;

@end

NS_ASSUME_NONNULL_END
