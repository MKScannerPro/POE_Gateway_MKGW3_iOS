
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerUploadDataOptionProtocol <NSObject>

/// V2版本固件
@property (nonatomic, assign)BOOL isV2;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL rawData_advertising;

/// V2中无此参数
@property (nonatomic, assign)BOOL rawData_response;

/// V2中有此参数
@property (nonatomic, assign)BOOL parsed_data;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
