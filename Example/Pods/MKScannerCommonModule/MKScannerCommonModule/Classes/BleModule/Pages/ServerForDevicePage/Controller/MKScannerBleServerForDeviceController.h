//
//  MKScannerBleServerForDeviceController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKScannerServerForDeviceProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleServerForDeviceController : MKScannerBleBaseController

/// 用户点击了配置参数
/*
success是否成功配置给设备了
 */
@property (nonatomic, copy)void (^updateCompleteBlock)(BOOL success);

- (instancetype)initWithProtocol:(id<MKScannerServerForDeviceProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
