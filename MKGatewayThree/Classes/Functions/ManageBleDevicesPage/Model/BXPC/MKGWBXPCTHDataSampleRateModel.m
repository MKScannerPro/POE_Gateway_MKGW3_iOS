//
//  MKGWBXPCTHDataSampleRateModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPCTHDataSampleRateModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPCTHDataSampleRateModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPCTHDataSampleRateWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
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
    [MKGWMQTTInterface gw_configBXPCSampleRate:[self.sampleRate integerValue]
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
