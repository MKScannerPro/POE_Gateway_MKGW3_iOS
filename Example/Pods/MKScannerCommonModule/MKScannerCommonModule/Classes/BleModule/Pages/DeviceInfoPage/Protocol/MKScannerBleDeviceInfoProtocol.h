#import "MKScannerBleDeviceInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBleDeviceInfoProtocol <NSObject>

- (void)readDataWithSucBlock:(void (^)(NSArray <MKScannerBleDeviceInfoModel *>*dataList))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
