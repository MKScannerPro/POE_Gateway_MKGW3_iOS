//
//  MKGWSystemTimeModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerSystemTimeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWSystemTimeModel : NSObject<MKScannerSystemTimeProtocol>

- (id <MKScannerNTPServerProtocol>)ntpServerProtocol;

- (void)readUTCTimeDataWithSucBlock:(void (^)(NSDictionary *dic))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configTimezone:(NSInteger)timeZone
             timestamp:(NSTimeInterval)timestamp
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
