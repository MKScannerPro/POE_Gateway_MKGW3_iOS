
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerRemoteReminderProtocol <NSObject>

/// 是否支持震动功能
@property (nonatomic, assign)BOOL supportVibarate;

- (void)ledRemoteReminderWithBlinkingTime:(NSInteger)blinkingTime
                         blinkingInterval:(NSInteger)blinkingInterval
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)buzzerRemoteReminderWithRingingTime:(NSInteger)ringingTime
                            ringingInterval:(NSInteger)ringingInterval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock;

@optional

- (void)vibrateRemoteReminderWithVibratingTime:(NSInteger)vibratingTime
                             vibrationInterval:(NSInteger)vibrationInterval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
