
#import "MKScannerButtonDfuV2Protocol.h"
#import "MKScannerButtonDfuV1Protocol.h"
#import "MKScannerRemoteReminderProtocol.h"
#import "MKScannerAccDataProtocol.h"
#import "MKScannerBXPCAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPButtonProtocol <NSObject>

@property (nonatomic, assign)BOOL isV2;

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV1Protocol>)dfuProtocol1;

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol2;

- (id <MKScannerRemoteReminderProtocol>)remoteReminderProtocol;

- (id <MKScannerAccDataProtocol>)accProtocol;

- (id <MKScannerBXPCAdvParamsProtocol>)advProtocol;

/// 清除事件计数
/// - Parameters:
///   - type: 0: single press 1: double press 2: long press
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
- (void)clearTriggerEventCountWithType:(NSInteger)type
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)dismissBXPButtonAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
