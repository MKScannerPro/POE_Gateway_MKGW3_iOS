//
//  MKGWBXPSTHDataSampleRateModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSTHDataSampleRateModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPSTHDataSampleRateModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPSTHDataSampleRateWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                         macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        self.sampleRate = [NSString stringWithFormat:@"%@",returnData[@"data"][@"sampling_rate"]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                        failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_configBXPSSampleRate:[self.sampleRate integerValue]
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
