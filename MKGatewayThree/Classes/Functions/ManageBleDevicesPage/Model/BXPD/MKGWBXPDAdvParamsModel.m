//
//  MKGWBXPDAdvParamsModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPDAdvParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPDAdvParamsModel

- (instancetype)init {
    if (self = [super init]) {
        _multiples = 100;
    }
    return self;
}

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPDAdvParamsWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock(returnData[@"data"][@"adv_param"]);
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configAdvParamsWithChannel:(NSInteger)channel
                          interval:(NSInteger)interval
                           txPower:(NSInteger)txPower
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_configBXPDAdvParamsWithChannel:channel
                                                interval:interval
                                                 txPower:txPower
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
