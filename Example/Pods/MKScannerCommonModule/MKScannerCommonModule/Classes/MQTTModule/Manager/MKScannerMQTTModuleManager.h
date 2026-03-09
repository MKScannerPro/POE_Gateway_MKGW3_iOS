//
//  MKScannerMQTTModuleManager.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const mk_scanner_deviceOfflineNotification;

extern NSString *const mk_scanner_deviceLoadChangedNotification;

@interface MKScannerMQTTModuleManager : NSObject

/// 设备断开连接
@property (nonatomic, copy)void (^deviceOfflineBlock)(void);

/// 设备负载状态改变Block，带负载的网关才有这个
/// state: 0:Load stop work!    1:Load start work!
@property (nonatomic, copy)void (^loadChangedBlock)(NSInteger state);



+ (MKScannerMQTTModuleManager *)shared;

+ (void)sharedDealloc;

@end

NS_ASSUME_NONNULL_END
