
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerReconnectTimeProtocol <NSObject>

@property (nonatomic, copy)NSString *timeout;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
