//
//  MKGWNearbyWifiModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBleNearbyWifiProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWNearbyWifiModel : NSObject

@property (nonatomic, copy)void (^receiveWifiBlock)(NSString *content);

- (void)startWifiScanWithSucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
