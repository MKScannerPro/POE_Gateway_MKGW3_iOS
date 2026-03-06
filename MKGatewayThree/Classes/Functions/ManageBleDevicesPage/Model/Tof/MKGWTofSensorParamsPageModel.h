//
//  MKGWTofSensorParamsPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerTofSensorParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWTofSensorParamsPageModel : NSObject<MKScannerTofSensorParamsProtocol>

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, copy)NSString *count;

@property (nonatomic, copy)NSString *time;

/// 0: Short distance 1:Long distance
@property (nonatomic, assign)NSInteger distanceMode;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
