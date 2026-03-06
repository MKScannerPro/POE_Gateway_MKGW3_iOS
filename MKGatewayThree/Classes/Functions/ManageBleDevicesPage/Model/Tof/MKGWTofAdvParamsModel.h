//
//  MKGWTofAdvParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerTofAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWTofAdvParamsModel : NSObject<MKScannerTofAdvParamsProtocol>

@property (nonatomic, copy)NSString *interval;

/// 0:  -40dBm 1:-20dBm   2:-16dBm   3:-12dBm   4:-8dBm    5:-4dBm    6:0dBm 7:3dBm     8:4dBm
@property (nonatomic, assign)NSInteger txPower;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
