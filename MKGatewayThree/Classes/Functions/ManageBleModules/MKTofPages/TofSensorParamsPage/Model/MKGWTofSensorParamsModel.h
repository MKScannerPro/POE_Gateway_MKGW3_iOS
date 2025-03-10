//
//  MKGWTofSensorParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWTofSensorParamsModel : NSObject

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, copy)NSString *count;

@property (nonatomic, copy)NSString *time;

/// 0: Short distance 1:Long distance
@property (nonatomic, assign)NSInteger distanceMode;

- (void)readDataWithBleMac:(NSString *)bleMac
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithBleMac:(NSString *)bleMac
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
