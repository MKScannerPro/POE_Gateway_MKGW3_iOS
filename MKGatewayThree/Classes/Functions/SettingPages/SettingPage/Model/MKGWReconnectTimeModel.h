//
//  MKGWReconnectTimeModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/11.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerReconnectTimeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWReconnectTimeModel : NSObject<MKScannerReconnectTimeProtocol>

@property (nonatomic, copy)NSString *timeout;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
