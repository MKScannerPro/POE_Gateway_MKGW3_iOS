//
//  MKGWTAdvParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBXPDAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWTAdvParamsModel : NSObject<MKScannerBXPDAdvParamsProtocol>

@property (nonatomic, assign)NSInteger multiples;

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置广播参数
/// - Parameters:
///   - channel: 0~5.
///   - interval: advterisment interval. 1 x 100ms ~ 100 x 100ms.
///   - txPower: 0~9:
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
- (void)configAdvParamsWithChannel:(NSInteger)channel
                          interval:(NSInteger)interval
                           txPower:(NSInteger)txPower
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
