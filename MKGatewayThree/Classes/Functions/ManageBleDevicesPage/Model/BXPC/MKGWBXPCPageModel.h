//
//  MKGWBXPCPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPCProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPCPageModel : NSObject<MKScannerBXPCProtocol>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol;

- (id <MKScannerRealTimeTHDataProtocol>)realTimeTHProtocol;

- (id <MKScannerBXPCHistoricalTHDataProtocol>)historicalTHDataProtocol;

- (id <MKScannerAccDataProtocol>)accProtocol;

- (id <MKScannerTHDataSampleRateProtocol>)sampleRateProtocol;

- (id <MKScannerBXPDAdvParamsProtocol>)advProtocol;

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
