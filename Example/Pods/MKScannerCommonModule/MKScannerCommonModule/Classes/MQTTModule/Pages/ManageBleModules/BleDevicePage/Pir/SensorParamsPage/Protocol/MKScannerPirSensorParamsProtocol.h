
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerPirSensorParamsProtocol <NSObject>

/// 0: Low 1:Medium  2:High
@property (nonatomic, assign)NSInteger sensitivity;

/// 0: Low 1:Medium  2:High
@property (nonatomic, assign)NSInteger delay;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
