//
//  MKGWPirSensorParamsPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerPirSensorParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWPirSensorParamsPageModel : NSObject<MKScannerPirSensorParamsProtocol>

/// 0: Low 1:Medium  2:High
@property (nonatomic, assign)NSInteger sensitivity;

/// 0: Low 1:Medium  2:High
@property (nonatomic, assign)NSInteger delay;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
