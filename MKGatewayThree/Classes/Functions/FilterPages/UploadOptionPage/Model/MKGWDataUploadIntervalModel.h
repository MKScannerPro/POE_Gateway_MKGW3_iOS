//
//  MKGWDataUploadIntervalModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/17.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerDataUploadIntervalProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDataUploadIntervalModel : NSObject<MKScannerDataUploadIntervalProtocol>

@property (nonatomic, copy)NSString *interval;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
