//
//  MKScannerDeviceModelManager.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerDeviceModelManager : NSObject

@property (nonatomic, strong, readonly)MKScannerDeviceModel *deviceModel;

@property (nonatomic, assign)BOOL isV2;

+ (MKScannerDeviceModelManager *)shared;

+ (void)sharedDealloc;

/// 当前设备的deviceID
- (NSString *)deviceID;

/// 当前设备的mac地址
- (NSString *)macAddress;

/// 当前设备的订阅主题
- (NSString *)subscribedTopic;

/// 本地存储的名字
- (NSString *)deviceName;

/// 当前需要托管的deviceModel
/// @param deviceModel deviceModel
- (void)addDeviceModel:(MKScannerDeviceModel *)deviceModel;

/// 清空当前托管的数据
- (void)clearDeviceModel;

- (void)updateDeviceName:(NSString *)deviceName;

@end

NS_ASSUME_NONNULL_END
