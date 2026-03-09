
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPCAdvParamsProtocol <NSObject>

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configAdvParams:(NSDictionary *)params
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
