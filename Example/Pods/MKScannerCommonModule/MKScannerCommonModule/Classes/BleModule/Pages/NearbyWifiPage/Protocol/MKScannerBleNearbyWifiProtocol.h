
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBleNearbyWifiProtocol <NSObject>

@property (nonatomic, copy)void (^receiveWifiBlock)(NSString *content);

- (void)startWifiScanWithSucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
