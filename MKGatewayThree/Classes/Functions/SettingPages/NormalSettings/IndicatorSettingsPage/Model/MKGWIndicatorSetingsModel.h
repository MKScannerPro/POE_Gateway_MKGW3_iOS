//
//  MKGWIndicatorSetingsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/11.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGWMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWIndicatorSetingsModel : NSObject<gw_indicatorLightStatusProtocol>

@property (nonatomic, assign)BOOL system_indicator;

@property (nonatomic, assign)BOOL network_indicator;

@property (nonatomic, assign)BOOL server_indicator;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
