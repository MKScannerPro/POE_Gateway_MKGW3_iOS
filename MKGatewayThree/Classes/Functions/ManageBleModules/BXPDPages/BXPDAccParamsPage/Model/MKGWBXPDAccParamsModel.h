//
//  MKGWBXPDAccParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPDAccParamsModel : NSObject

/// 0: 1Hz 1:10Hz 2:25Hz    3:50Hz  4:100Hz
@property (nonatomic, assign)NSInteger sampleRate;

/// 0:2g    1:4g    2:8g    3:16g
@property (nonatomic, assign)NSInteger scale;

@property (nonatomic, copy)NSString *sensitivity;

- (void)readDataWithBleMac:(NSString *)bleMac
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithBleMac:(NSString *)bleMac
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
