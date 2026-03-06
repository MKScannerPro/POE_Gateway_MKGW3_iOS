//
//  MKGWBXPTRemoteReminderPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPSReminderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPTRemoteReminderPageModel : NSObject<MKScannerBXPSReminderProtocol>

@property (nonatomic, assign)NSInteger color;

@property (nonatomic, copy)NSString *blinkingTime;

@property (nonatomic, copy)NSString *blinkingInterval;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
