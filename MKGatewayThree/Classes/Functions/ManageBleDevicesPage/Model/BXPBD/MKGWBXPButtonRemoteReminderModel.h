//
//  MKGWBXPButtonRemoteReminderModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerRemoteReminderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPButtonRemoteReminderModel : NSObject<MKScannerRemoteReminderProtocol>

/// 是否支持震动功能
@property (nonatomic, assign)BOOL supportVibarate;

- (void)ledRemoteReminderWithBlinkingTime:(NSInteger)blinkingTime
                         blinkingInterval:(NSInteger)blinkingInterval
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)buzzerRemoteReminderWithRingingTime:(NSInteger)ringingTime
                            ringingInterval:(NSInteger)ringingInterval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
