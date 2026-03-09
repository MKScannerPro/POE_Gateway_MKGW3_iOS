
#import "MKScannerExcelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerServerForDeviceProtocol <MKScannerExcelDeviceProtocol>

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientKeyName;

@property (nonatomic, copy)NSString *clientCertName;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *deviceName;

/// 校验当前参数
- (NSString *)checkParams;

/// 更新数据
/// @param json 数据源
- (void)updateValue:(NSDictionary *)json;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
