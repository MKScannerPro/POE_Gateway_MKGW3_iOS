//
//  MKGWPirAdvParamsModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWPirAdvParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWPirAdvParamsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readMKPirAdvParamsWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:^(id  _Nonnull returnData) {
        self.interval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"adv_interval"]];
        self.txPower = [self fetchTxPower:[returnData[@"data"][@"tx_power"] integerValue]];
        if (sucBlock) {
            sucBlock();
        }
    }
                                                  failedBlock:failedBlock];
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_configMKPirAdvParamsWithInterval:[self.interval integerValue]
                                                   txPower:self.txPower
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

#pragma mark - private method
- (NSInteger)fetchTxPower:(NSInteger)txPower {
    if (txPower == 0) {
        //4dBm
        return 7;
    }
    if (txPower == 1) {
        //0dBm
        return 6;
    }
    if (txPower == 2) {
        //-4dBm
        return 5;
    }
    if (txPower == 3) {
        //-8dBm
        return 4;
    }
    if (txPower == 4) {
        //-12dBm
        return 3;
    }
    if (txPower == 5) {
        //-16dBm
        return 2;
    }
    if (txPower == 6) {
        //-20dBm
        return 1;
    }
    return 0;
}

@end
