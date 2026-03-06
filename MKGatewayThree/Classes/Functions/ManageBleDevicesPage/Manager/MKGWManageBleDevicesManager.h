//
//  MKGWManageBleDevicesManager.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWManageBleDevicesManager : NSObject

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

+ (MKGWManageBleDevicesManager *)shared;

+ (void)sharedDealloc;

- (NSString *)bleMac;

@end

NS_ASSUME_NONNULL_END
