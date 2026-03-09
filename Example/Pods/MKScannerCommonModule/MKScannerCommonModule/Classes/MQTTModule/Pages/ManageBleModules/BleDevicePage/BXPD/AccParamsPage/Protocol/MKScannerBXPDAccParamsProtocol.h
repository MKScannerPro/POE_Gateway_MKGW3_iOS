
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPDAccParamsProtocol <NSObject>

/// 0: 1Hz 1:10Hz 2:25Hz    3:50Hz  4:100Hz
@property (nonatomic, assign)NSInteger sampleRate;

/// 0:2g    1:4g    2:8g    3:16g
@property (nonatomic, assign)NSInteger scale;

/// 1x100ms - 2048x100ms
@property (nonatomic, copy)NSString *sensitivity;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
