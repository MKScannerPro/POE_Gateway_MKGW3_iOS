//
//  MKGWBXPButtonPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

#import "MKGWButtonDFUModel.h"
#import "MKGWButtonDFUV2Model.h"

#import "MKGWBXPButtonAccDataPageModel.h"
#import "MKGWBXPButtonAdvParamsModel.h"
#import "MKGWBXPButtonRemoteReminderModel.h"

@implementation MKGWBXPButtonPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPButtonPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _title = [MKScannerDeviceModelManager shared].deviceName;
        _isV2 = [MKScannerDeviceModelManager shared].isV2;
        _deviceBleInfo = [MKGWManageBleDevicesManager shared].deviceBleInfo;
        [self addNotes];
    }
    return self;
}

- (id <MKScannerButtonDfuV1Protocol>)dfuProtocol1 {
    return [[MKGWButtonDFUModel alloc] init];
}

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol2 {
    return [[MKGWButtonDFUV2Model alloc] init];
}

- (id <MKScannerRemoteReminderProtocol>)remoteReminderProtocol {
    return [[MKGWBXPButtonRemoteReminderModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGWBXPButtonAccDataPageModel alloc] init];
}

- (id <MKScannerBXPCAdvParamsProtocol>)advProtocol {
    return [[MKGWBXPButtonAdvParamsModel alloc] init];
}

- (void)clearTriggerEventCountWithType:(NSInteger)type
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_clearTriggerEventCount:type
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

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPButtonConnectedStatusWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                             macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:sucBlock
                                                            failedBlock:failedBlock];
}

- (void)dismissBXPButtonAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_dismissBXPButtonAlarmStatusWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:sucBlock
                                                           failedBlock:failedBlock];
}

- (void)disconnectWithSucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_disconnectNormalBleDeviceWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:sucBlock
                                                  failedBlock:failedBlock];
}

- (void)powerOffWithSucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBtnRemotePowerOffWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:sucBlock
                                             failedBlock:failedBlock];
}

#pragma mark - notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:self.deviceBleInfo[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDisconnectBlock) {
        self.receiveDisconnectBlock();
    }
}

- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGWReceiveGatewayDisconnectBXPButtonNotification
                                               object:nil];
}

@end
