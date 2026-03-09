
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPSHistoricalTHDataProtocol <NSObject>

@property (nonatomic, copy) void (^receiveHTDataBlock)(NSArray <NSDictionary *>*historyList);

/// 监听温湿度历史数据数据
- (void)notifyHistoricalHTData:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 删除温湿度历史数据
- (void)deleteHistoricalHTDataWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
