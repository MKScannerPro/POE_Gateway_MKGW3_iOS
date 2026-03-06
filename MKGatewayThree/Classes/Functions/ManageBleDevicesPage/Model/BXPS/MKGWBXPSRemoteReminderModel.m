//
//  MKGWBXPSRemoteReminderModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSRemoteReminderModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPSRemoteReminderModel

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBXPSLedRemoteReminderWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                       color:self.color
                                                blinkingTime:[self.blinkingTime integerValue]
                                            blinkingInterval:[self.blinkingInterval integerValue]
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
