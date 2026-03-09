
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerResetByButtonProtocol <NSObject>

/// 0:Disable 1:Press in 1 minute after powered 2:Press any time
@property (nonatomic, assign)NSInteger type;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
