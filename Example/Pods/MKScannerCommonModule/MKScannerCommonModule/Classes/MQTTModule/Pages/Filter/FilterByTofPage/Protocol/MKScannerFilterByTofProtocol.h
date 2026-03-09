
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerFilterByTofProtocol <NSObject>

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, strong)NSArray *codeList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithCodeList:(NSArray <NSString *>*)codeList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
