//
//  MKGWBXPSAdvParamsModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSAdvParamsModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPSAdvParamsModel

- (void)readAdvParamsWithSucBlock:(void (^)(NSArray *dataList))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPSAdvParamsWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock(returnData[@"data"][@"adv_param"]);
        }
    }
                                                 failedBlock:failedBlock];
}

- (void)configAdvParams:(NSDictionary *)params
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_configBXPSAdvParamsWithParams:params
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
