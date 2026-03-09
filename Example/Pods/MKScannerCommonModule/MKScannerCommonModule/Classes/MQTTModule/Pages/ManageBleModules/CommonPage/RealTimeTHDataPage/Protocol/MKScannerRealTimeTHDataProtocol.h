
NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerRealTimeTHDataProtocol <NSObject>

/// 发送邮件的时候的文件名字:BXP-C RealTimeHTDatas.txt
@property (nonatomic, copy)NSString *mailFileName;

@property (nonatomic, copy)void (^receiveHTDataBlock)(NSString *temperature, NSString *humidity);

/// 监听实时的温湿度数据
- (void)notifyRealTimeHTData:(BOOL)isOn
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
