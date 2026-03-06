//
//  MKGWBXPButtonCRRemoteReminderModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRRemoteReminderModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPButtonCRRemoteReminderModel

- (instancetype)init {
    if (self = [super init]) {
        _supportVibarate = YES;
    }
    return self;
}

- (void)ledRemoteReminderWithBlinkingTime:(NSInteger)blinkingTime
                         blinkingInterval:(NSInteger)blinkingInterval
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBtnCRLedRemoteReminderWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                 blinkingTime:blinkingTime
                                             blinkingInterval:blinkingInterval
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                  failedBlock:failedBlock];
}

- (void)buzzerRemoteReminderWithRingingTime:(NSInteger)ringingTime
                            ringingInterval:(NSInteger)ringingInterval
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBtnCRBuzzerRemoteReminderWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                        ringTime:ringingTime
                                                    ringInterval:ringingInterval
                                                      macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                           topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                        sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                     failedBlock:failedBlock];
}

- (void)vibrateRemoteReminderWithVibratingTime:(NSInteger)vibratingTime
                             vibrationInterval:(NSInteger)vibrationInterval
                                      sucBlock:(void (^)(void))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBtnCRVibratingRemoteReminderWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                      vibratingTime:vibratingTime
                                                  vibratingInterval:vibrationInterval
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
