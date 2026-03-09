
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerNTPServerProtocol <NSObject>

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *host;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
