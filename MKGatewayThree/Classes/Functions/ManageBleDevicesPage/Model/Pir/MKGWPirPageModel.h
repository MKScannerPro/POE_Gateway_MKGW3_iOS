//
//  MKGWPirPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerPirProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWPirPageModel : NSObject<MKScannerPirProtocol>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol;

- (id <MKScannerPirAdvParamsProtocol>)advProtocol;

- (id <MKScannerPirSensorDataProtocol>)sensorDataProtocol;

- (id <MKScannerPirSensorParamsProtocol>)sensorParamsProtocol;

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
