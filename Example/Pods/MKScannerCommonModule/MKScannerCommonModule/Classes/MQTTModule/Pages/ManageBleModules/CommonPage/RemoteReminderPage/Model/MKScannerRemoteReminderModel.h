//
//  MKScannerRemoteReminderModel.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerRemoteReminderModel : NSObject

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
