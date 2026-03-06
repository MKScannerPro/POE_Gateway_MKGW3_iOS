//
//  MKGWBXPSHallCountPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPSHallCountProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPSHallCountPageModel : NSObject<MKScannerBXPSHallCountProtocol>

- (void)readDataWithSucBlock:(void (^)(NSString *count))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)clearHallCountWithSucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
