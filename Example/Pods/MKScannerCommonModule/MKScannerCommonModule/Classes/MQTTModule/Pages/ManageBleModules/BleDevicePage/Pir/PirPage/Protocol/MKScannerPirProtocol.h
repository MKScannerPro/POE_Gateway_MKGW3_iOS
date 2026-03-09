
#import "MKScannerButtonDfuV2Protocol.h"
#import "MKScannerPirAdvParamsProtocol.h"
#import "MKScannerPirSensorDataProtocol.h"
#import "MKScannerPirSensorParamsProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerPirProtocol <NSObject>

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
