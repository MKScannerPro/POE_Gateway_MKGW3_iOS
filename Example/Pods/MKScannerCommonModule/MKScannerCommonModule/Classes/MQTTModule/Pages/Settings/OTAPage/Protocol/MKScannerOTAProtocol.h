
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerOTAProtocol <NSObject>

/// 0:Wifi OTA   1:NCP OTA
@property (nonatomic, assign)NSInteger otaType;

@property (nonatomic, copy)NSString *filePath;

@property (nonatomic, copy)void (^receiveOTAResult)(NSInteger result);


- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
