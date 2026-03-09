
NS_ASSUME_NONNULL_BEGIN

//BXP-T/BXP-S使用这个

@protocol MKScannerBXPSReminderProtocol <NSObject>

@property (nonatomic, assign)NSInteger color;

@property (nonatomic, copy)NSString *blinkingTime;

@property (nonatomic, copy)NSString *blinkingInterval;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
