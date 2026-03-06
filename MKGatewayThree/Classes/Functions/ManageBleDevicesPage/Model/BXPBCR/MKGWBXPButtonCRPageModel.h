//
//  MKGWBXPButtonCRPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPButtonCRProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPButtonCRPageModel : NSObject<MKScannerBXPButtonCRProtocol>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol;

- (id <MKScannerRemoteReminderProtocol>)remoteReminderProtocol;

- (id <MKScannerAccDataProtocol>)accProtocol;

- (id <MKScannerBXPButtonCRAlarmEventProtocol>)alarmEventProtocol;

- (id <MKScannerBXPCAdvParamsProtocol>)advProtocol;

/// 清除事件计数
/// - Parameters:
///   - type: 0: single press 1: double press 2: long press
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
- (void)clearEventCountWithType:(NSInteger)type
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)dismissBXPButtonCRAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
