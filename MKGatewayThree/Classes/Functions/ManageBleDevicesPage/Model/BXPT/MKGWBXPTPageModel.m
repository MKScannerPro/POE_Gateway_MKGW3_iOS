//
//  MKGWBXPTPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPTPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

#import "MKGWButtonDFUV2Model.h"

#import "MKGWBXPTAccDataPageModel.h"
#import "MKGWBXPTAccParamsModel.h"
#import "MKGWBXPTMotionEventPageModel.h"
#import "MKGWBXPTRemoteReminderPageModel.h"
#import "MKGWTAdvParamsModel.h"


@implementation MKGWBXPTPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPTPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _title = [MKScannerDeviceModelManager shared].deviceName;
        _deviceBleInfo = [MKGWManageBleDevicesManager shared].deviceBleInfo;
        [self addNotes];
    }
    return self;
}

- (id <MKScannerButtonDfuV2Protocol>)dfuProtocol {
    return [[MKGWButtonDFUV2Model alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGWBXPTAccDataPageModel alloc] init];
}

- (id <MKScannerBXPTAccParamsProtocol>)accParamsProtocol {
    return [[MKGWBXPTAccParamsModel alloc] init];
}

- (id <MKScannerBXPDAdvParamsProtocol>)advProtocol {
    return [[MKGWTAdvParamsModel alloc] init];
}

- (id <MKScannerBXPSReminderProtocol>)reminderProtocol {
    return [[MKGWBXPTRemoteReminderPageModel alloc] init];
}

- (id <MKScannerBXPTMotionEventProtocol>)eventProtocol {
    return [[MKGWBXPTMotionEventPageModel alloc] init];
}

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPTConnectedStatusWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
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
    [MKGWMQTTInterface gw_bxpBXPTPowerOffWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
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
