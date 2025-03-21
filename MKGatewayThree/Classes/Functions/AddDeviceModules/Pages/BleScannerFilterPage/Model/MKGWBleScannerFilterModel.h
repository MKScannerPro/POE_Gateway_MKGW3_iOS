//
//  MKGWBleScannerFilterModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/31.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBleScannerFilterModel : NSObject

@property (nonatomic, assign)NSInteger rssi;

/// 0~6 Bytes
@property (nonatomic, copy)NSString *macAddress;

/// 0~20 Characters
@property (nonatomic, copy)NSString *advName;

/// 0s~86400s
@property (nonatomic, copy)NSString *interval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
