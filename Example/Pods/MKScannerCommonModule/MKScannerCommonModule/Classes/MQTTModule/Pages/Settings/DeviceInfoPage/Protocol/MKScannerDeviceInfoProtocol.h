
#import "MKScannerDeviceInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerDeviceInfoProtocol <NSObject>

- (void)readDataWithSucBlock:(void (^)(NSArray <MKScannerDeviceInfoModel *>*dataList))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
