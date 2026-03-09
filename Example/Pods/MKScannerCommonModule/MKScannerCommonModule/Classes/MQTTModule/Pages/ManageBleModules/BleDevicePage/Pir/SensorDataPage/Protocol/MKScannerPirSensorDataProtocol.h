
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerPirSensorDataProtocol <NSObject>

@property (nonatomic, copy)void (^receiveSensorDataBlock)(NSString *doorState,NSString *pirState);

/// 监听Sensor数据
- (void)notifySensorData:(BOOL)isOn
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
