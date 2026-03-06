//
//  MKGWDuplicateDataFilterModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/6..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerDuplicateDataFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDuplicateDataFilterModel : NSObject<MKScannerDuplicateDataFilterProtocol>

/// 0:None    1:MAC   2:MAC+Data  type  3:MAC+Raw data
@property (nonatomic, assign)NSInteger rule;

@property (nonatomic, copy)NSString *time;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
