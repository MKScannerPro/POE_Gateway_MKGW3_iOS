//
//  MKGWBXPSRealTimeTHDataPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerRealTimeTHDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPSRealTimeTHDataPageModel : NSObject<MKScannerRealTimeTHDataProtocol>

/// 发送邮件的时候的文件名字:BXP-C RealTimeHTDatas.txt
@property (nonatomic, copy)NSString *mailFileName;

@property (nonatomic, copy)void (^receiveHTDataBlock)(NSString *temperature, NSString *humidity);

/// 监听实时的温湿度数据
- (void)notifyRealTimeHTData:(BOOL)isOn
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
