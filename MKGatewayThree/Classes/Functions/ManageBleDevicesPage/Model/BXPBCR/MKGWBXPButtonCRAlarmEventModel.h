//
//  MKGWBXPButtonCRAlarmEventModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPButtonCRAlarmEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPButtonCRAlarmEventModel : NSObject<MKScannerBXPButtonCRAlarmEventProtocol>

/// 接收到Alarm数据回调。timestamp接收到数据的时间戳，type=0:Single press mode type=1:Double press mode type=2:Long press mode
@property (nonatomic, copy)void (^receiveAlarmDataBlock)(long long timestamp, NSInteger type);

/// 监听Alarm数据
- (void)notifyAlarmData:(BOOL)isOn
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
