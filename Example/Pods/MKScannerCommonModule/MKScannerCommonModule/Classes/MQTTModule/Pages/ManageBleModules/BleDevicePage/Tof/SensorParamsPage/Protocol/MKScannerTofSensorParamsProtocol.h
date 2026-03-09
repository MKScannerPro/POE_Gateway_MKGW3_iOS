
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerTofSensorParamsProtocol <NSObject>

@property (nonatomic, copy)NSString *interval;

@property (nonatomic, copy)NSString *count;

@property (nonatomic, copy)NSString *time;

/// 0: Short distance 1:Long distance
@property (nonatomic, assign)NSInteger distanceMode;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
