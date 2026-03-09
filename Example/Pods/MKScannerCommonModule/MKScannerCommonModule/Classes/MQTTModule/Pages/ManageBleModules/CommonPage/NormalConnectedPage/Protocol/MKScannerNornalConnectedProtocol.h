
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerNornalConnectedProtocol <NSObject>

@property (nonatomic, copy)NSString *title;

@property (nonatomic, strong)NSArray <NSDictionary *>*serviceList;

/// 设备断开连接
@property (nonatomic, copy)void (^receiveDisconnectBlock)(void);

/// 操作设备的特征返回的数据
@property (nonatomic, copy)void (^receiveDeviceDatasBlock)(NSDictionary *dataDic);

/// 断开设备连接
/// - Parameters:
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
- (void)disconnectWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

- (void)writeData:(NSString *)data
      serviceUUID:(NSString *)serverUUID
   characteristic:(NSString *)characteristic
         sucBlock:(void (^)(id returnData))sucBlock
      failedBlock:(void (^)(NSError *error))failedBlock;

- (void)readDataWithServiceUUID:(NSString *)serverUUID
                 characteristic:(NSString *)characteristic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

- (void)notify:(BOOL)notify
   serviceUUID:(NSString *)serverUUID
characteristic:(NSString *)characteristic
      sucBlock:(void (^)(id returnData))sucBlock
   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
