//
//  MKGWBXPCHistoricalTHDataPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPCHistoricalTHDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPCHistoricalTHDataPageModel : NSObject<MKScannerBXPCHistoricalTHDataProtocol>

@property (nonatomic, copy)void (^receiveHTDataBlock)(long long timestamp, float temperature, float humidity);

/// 监听温湿度历史数据数据
- (void)notifyHistoricalHTData:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 删除温湿度历史数据
- (void)deleteHistoricalHTDataWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
