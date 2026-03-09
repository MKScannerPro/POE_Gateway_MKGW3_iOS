
#import "MKScannerButtonDfuV2Protocol.h"
#import "MKScannerBXPTAccParamsProtocol.h"
#import "MKScannerAccDataProtocol.h"
#import "MKScannerBXPDAdvParamsProtocol.h"
#import "MKScannerBXPSReminderProtocol.h"
#import "MKScannerBXPTMotionEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPTProtocol <NSObject>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol;

- (id <MKScannerAccDataProtocol>)accProtocol;

- (id <MKScannerBXPTAccParamsProtocol>)accParamsProtocol;

- (id <MKScannerBXPDAdvParamsProtocol>)advProtocol;

- (id <MKScannerBXPSReminderProtocol>)reminderProtocol;

- (id <MKScannerBXPTMotionEventProtocol>)eventProtocol;

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
