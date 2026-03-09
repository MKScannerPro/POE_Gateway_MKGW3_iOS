
#import "MKScannerButtonDfuV2Protocol.h"
#import "MKScannerRealTimeTHDataProtocol.h"
#import "MKScannerBXPSHistoricalTHDataProtocol.h"
#import "MKScannerTHDataSampleRateProtocol.h"
#import "MKScannerBXPSHallCountProtocol.h"
#import "MKScannerBXPSReminderProtocol.h"
#import "MKScannerBXPSAdvParamsProtocol.h"
#import "MKScannerAccDataProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPSProtocol <NSObject>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSDictionary *deviceBleInfo;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol;

- (id <MKScannerRealTimeTHDataProtocol>)realTimeTHDataProtocol;

- (id <MKScannerBXPSHistoricalTHDataProtocol>)historicalTHDataProtocol;

- (id <MKScannerAccDataProtocol>)accProtocol;

- (id <MKScannerTHDataSampleRateProtocol>)sampleRateProtocol;

- (id <MKScannerBXPSHallCountProtocol>)hallCountProtocol;

- (id <MKScannerBXPSReminderProtocol>)remoteReminderProtocol;

- (id <MKScannerBXPSAdvParamsProtocol>)advProtocol;


- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
