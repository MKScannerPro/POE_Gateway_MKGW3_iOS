//
//  MKGWTofAdvParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWTofAdvParamsModel : NSObject

@property (nonatomic, copy)NSString *interval;

/// 0:  -40dBm 1:-20dBm   2:-16dBm   3:-12dBm   4:-8dBm    5:-4dBm    6:0dBm 7:3dBm     8:4dBm
@property (nonatomic, assign)NSInteger txPower;

- (void)readDataWithBleMac:(NSString *)bleMac
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithBleMac:(NSString *)bleMac
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
