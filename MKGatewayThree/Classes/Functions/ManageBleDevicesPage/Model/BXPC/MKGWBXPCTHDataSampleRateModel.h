//
//  MKGWBXPCTHDataSampleRateModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerTHDataSampleRateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPCTHDataSampleRateModel : NSObject<MKScannerTHDataSampleRateProtocol>

@property (nonatomic, copy)NSString *sampleRate;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
