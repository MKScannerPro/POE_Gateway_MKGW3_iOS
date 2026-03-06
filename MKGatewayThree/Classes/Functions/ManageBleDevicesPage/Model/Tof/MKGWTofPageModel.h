//
//  MKGWTofPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerTofProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWTofPageModel : NSObject<MKScannerTofProtocol>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol;

- (id <MKScannerTofAdvParamsProtocol>)advProtocol;

- (id <MKScannerAccDataProtocol>)accDataProtocol;

- (id <MKScannerTofSensorDataProtocol>)sensorDataProtocol;

- (id <MKScannerTofSensorParamsProtocol>)sensorParamsProtocol;

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
