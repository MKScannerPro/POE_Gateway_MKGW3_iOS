
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerFilterByNanoBeaconProtocol <NSObject>

@property (nonatomic, assign)BOOL isOn;

/// 0:Normal type 1:Trigger type 2:All
@property (nonatomic, assign)NSInteger triggerType;

@property (nonatomic, strong)NSArray *manufactureList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithManufactureList:(NSArray <NSString *>*)manufactureList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
