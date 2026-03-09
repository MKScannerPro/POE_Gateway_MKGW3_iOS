
#import "MKScannerNTPServerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerSystemTimeProtocol <NSObject>

- (id <MKScannerNTPServerProtocol>)ntpServerProtocol;

- (void)readUTCTimeDataWithSucBlock:(void (^)(NSDictionary *dic))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configTimezone:(NSInteger)timeZone
             timestamp:(NSTimeInterval)timestamp
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
