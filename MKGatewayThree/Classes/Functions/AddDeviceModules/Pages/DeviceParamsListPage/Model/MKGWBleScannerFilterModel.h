//
//  MKGWBleScannerFilterModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/31.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBleScannerFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBleScannerFilterModel : NSObject<MKScannerBleScannerFilterProtocol>

/// 当前页面的title
@property (nonatomic, copy)NSString *title;

@property (nonatomic, assign)NSInteger rssi;

/// 0~6 Bytes
@property (nonatomic, copy)NSString *macAddress;

/// 0~20 Characters
@property (nonatomic, copy)NSString *advName;

/// 只有新版本的才支持Report Interval
@property (nonatomic, assign)BOOL supportInterval;

/// 0s~86400s
@property (nonatomic, copy)NSString *interval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
