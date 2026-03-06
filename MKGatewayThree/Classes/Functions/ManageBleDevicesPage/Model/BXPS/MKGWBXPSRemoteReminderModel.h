//
//  MKGWBXPSRemoteReminderModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPSReminderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPSRemoteReminderModel : NSObject<MKScannerBXPSReminderProtocol>

@property (nonatomic, assign)NSInteger color;

@property (nonatomic, copy)NSString *blinkingTime;

@property (nonatomic, copy)NSString *blinkingInterval;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
