
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerFilterByOtherProtocol <NSObject>

@property (nonatomic, assign)BOOL isOn;

/*
 0:A
 1:A & B
 2:A | B
 3:A & B & C
 4:(A & B) | C
 5:A | B | C
 */
@property (nonatomic, assign)NSInteger relationship;

@property (nonatomic, strong)NSArray *rawDataList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置参数
/// - Parameters:
///   - list: 参数列表，如下
/*
 @{
    @"dataType":@"00",  //当前过滤的数据类型，参考国际蓝牙组织对不同蓝牙数据类型的定义
    @"minIndex":@"0",   //开始过滤的Byte索引
    @"maxIndex":@"2",   //截止过滤的Byte索引
    @"rawData":@"AABBCCDDEEFF", //当前过滤的内容
 }
 */
///   - relationship: 0:A 1:A & B 2:A | B 3:A & B & C 4:(A & B) | C 5:A | B | C
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
- (void)configWithRawDataList:(NSArray <NSDictionary *>*)list
                 relationship:(NSInteger)relationship
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
