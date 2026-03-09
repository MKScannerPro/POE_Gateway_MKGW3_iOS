
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPTMotionEventProtocol <NSObject>

- (void)readDataWithSucBlock:(void (^)(NSString *count))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

- (void)clearHallCountWithSucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
