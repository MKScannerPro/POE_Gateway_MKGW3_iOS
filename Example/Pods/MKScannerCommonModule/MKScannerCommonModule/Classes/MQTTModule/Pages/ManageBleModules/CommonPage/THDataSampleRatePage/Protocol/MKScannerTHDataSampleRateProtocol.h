
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerTHDataSampleRateProtocol <NSObject>

@property (nonatomic, copy)NSString *sampleRate;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
