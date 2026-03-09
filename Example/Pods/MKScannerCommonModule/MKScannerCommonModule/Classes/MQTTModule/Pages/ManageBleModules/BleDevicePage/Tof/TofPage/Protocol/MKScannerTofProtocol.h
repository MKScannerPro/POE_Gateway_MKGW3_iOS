
#import "MKScannerButtonDfuV2Protocol.h"
#import "MKScannerTofAdvParamsProtocol.h"
#import "MKScannerTofSensorDataProtocol.h"
#import "MKScannerTofSensorParamsProtocol.h"
#import "MKScannerAccDataProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerTofProtocol <NSObject>

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
