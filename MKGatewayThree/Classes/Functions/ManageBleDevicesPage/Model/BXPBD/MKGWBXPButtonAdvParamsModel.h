//
//  MKGWBXPButtonAdvParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPCAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPButtonAdvParamsModel : NSObject<MKScannerBXPCAdvParamsProtocol>

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configAdvParams:(NSDictionary *)params
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
