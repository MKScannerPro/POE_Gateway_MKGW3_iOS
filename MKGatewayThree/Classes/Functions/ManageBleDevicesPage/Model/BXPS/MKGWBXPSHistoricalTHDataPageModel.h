//
//  MKGWBXPSHistoricalTHDataPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPSHistoricalTHDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPSHistoricalTHDataPageModel : NSObject<MKScannerBXPSHistoricalTHDataProtocol>

@property (nonatomic, copy) void (^receiveHTDataBlock)(NSArray <NSDictionary *>*historyList);

/// 监听温湿度历史数据数据
- (void)notifyHistoricalHTData:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// 删除温湿度历史数据
- (void)deleteHistoricalHTDataWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
