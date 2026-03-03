//
//  MKGWSystemTimeModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWSystemTimeModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTInterface.h"

#import "MKGWNTPServerModel.h"

@implementation MKGWSystemTimeModel

- (id <MKScannerNTPServerProtocol>)ntpServerProtocol {
    return [[MKGWNTPServerModel alloc] init];
}

- (void)readUTCTimeDataWithSucBlock:(void (^)(NSDictionary *dic))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readDeviceUTCTimeWithMacAddress:[MKScannerDeviceModelManager shared].macAddress
                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                 sucBlock:sucBlock
                                              failedBlock:failedBlock];
}

- (void)configTimezone:(NSInteger)timeZone
             timestamp:(NSTimeInterval)timestamp
              sucBlock:(void (^)(void))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_configDeviceTimeZone:timeZone
                                     timestamp:timestamp
                                    macAddress:[MKScannerDeviceModelManager shared].macAddress
                                         topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                      sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                   failedBlock:failedBlock];
}

@end
