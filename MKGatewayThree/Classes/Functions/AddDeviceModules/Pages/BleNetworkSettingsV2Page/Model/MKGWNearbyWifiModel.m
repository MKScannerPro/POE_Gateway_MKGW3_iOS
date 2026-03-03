//
//  MKGWNearbyWifiModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWNearbyWifiModel.h"

#import "MKGWCentralManager.h"
#import "MKGWInterface+MKGWConfig.h"

@interface MKGWNearbyWifiModel ()<mk_gw_centralManagerScanWifiDelegate>

@end

@implementation MKGWNearbyWifiModel

#pragma mark - mk_gw_centralManagerScanWifiDelegate
- (void)mk_gw_receiveWifi:(NSString *)content {
    if (self.receiveWifiBlock) {
        self.receiveWifiBlock(content);
    }
}

- (void)startWifiScanWithSucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWInterface gw_startWifiScanWithSucBlock:^{
        [MKGWCentralManager shared].wifiDelegate = self;
    } failedBlock:failedBlock];
}

@end
