
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerTofAdvParamsProtocol <NSObject>

@property (nonatomic, copy)NSString *interval;

/// 0:  -40dBm 1:-20dBm   2:-16dBm   3:-12dBm   4:-8dBm    5:-4dBm    6:0dBm 7:3dBm     8:4dBm
@property (nonatomic, assign)NSInteger txPower;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
