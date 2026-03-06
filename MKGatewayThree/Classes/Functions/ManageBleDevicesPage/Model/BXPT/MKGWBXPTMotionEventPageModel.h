//
//  MKGWBXPTMotionEventPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPTMotionEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPTMotionEventPageModel : NSObject<MKScannerBXPTMotionEventProtocol>

- (void)readDataWithSucBlock:(void (^)(NSString *count))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)clearHallCountWithSucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
