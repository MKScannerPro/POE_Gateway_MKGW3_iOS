//
//  MKGWBXPDAccParamsModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPDAccParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"


@implementation MKGWBXPDAccParamsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPDAccParamsWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        self.scale = [returnData[@"data"][@"full_scale"] integerValue];
        self.sampleRate = [returnData[@"data"][@"sampling_rate"] integerValue];
        self.sensitivity = [NSString stringWithFormat:@"%@",returnData[@"data"][@"sensitivity"]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_configBXPDAccParamsWithScale:self.scale
                                            sampleRate:self.sampleRate
                                           sensitivity:[self.sensitivity integerValue]
                                                bleMac:[MKGWManageBleDevicesManager shared].bleMac
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
