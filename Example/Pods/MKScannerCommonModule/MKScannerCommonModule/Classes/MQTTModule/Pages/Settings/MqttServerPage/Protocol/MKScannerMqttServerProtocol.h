
#import "MKScannerExcelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerMqttServerProtocol <MKScannerExcelDeviceProtocol>

/// 0:TCP    1:CA signed server certificate     2:CA certificate     3:Self signed certificates
@property (nonatomic, assign)NSInteger connectMode;

@property (nonatomic, copy)NSString *caFilePath;

@property (nonatomic, copy)NSString *clientKeyPath;

@property (nonatomic, copy)NSString *clientCertPath;

/// 整数更新完成回调，1:成功 其他:失败
@property (nonatomic, copy)void (^receiveUpdateCertsBlock)(NSInteger result);

/// 校验当前参数
- (NSString *)checkParams;

/// 更新数据
/// @param model 数据源
- (void)updateValue:(NSDictionary *)json;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
