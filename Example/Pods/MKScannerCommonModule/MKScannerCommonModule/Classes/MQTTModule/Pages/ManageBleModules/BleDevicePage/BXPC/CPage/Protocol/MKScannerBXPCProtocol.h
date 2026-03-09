
#import "MKScannerButtonDfuV2Protocol.h"
#import "MKScannerRealTimeTHDataProtocol.h"
#import "MKScannerBXPCHistoricalTHDataProtocol.h"
#import "MKScannerAccDataProtocol.h"
#import "MKScannerTHDataSampleRateProtocol.h"
#import "MKScannerBXPDAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPCProtocol <NSObject>

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
