//
//  MKGWPirSensorDataPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerPirSensorDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWPirSensorDataPageModel : NSObject<MKScannerPirSensorDataProtocol>

@property (nonatomic, copy)void (^receiveSensorDataBlock)(NSString *doorState,NSString *pirState);

/// 监听Sensor数据
- (void)notifySensorData:(BOOL)isOn
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
