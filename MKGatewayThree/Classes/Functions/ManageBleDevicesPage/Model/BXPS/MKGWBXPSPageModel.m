//
//  MKGWBXPSPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

#import "MKGWButtonDFUV2Model.h"

#import "MKGWBXPSAccDataPageModel.h"
#import "MKGWBXPSAdvParamsModel.h"
#import "MKGWBXPSHallCountPageModel.h"
#import "MKGWBXPSHistoricalTHDataPageModel.h"
#import "MKGWBXPSRealTimeTHDataPageModel.h"
#import "MKGWBXPSRemoteReminderModel.h"
#import "MKGWBXPSTHDataSampleRateModel.h""


@implementation MKGWBXPSPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPSPageModel销毁");
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

- (id <MKScannerRealTimeTHDataProtocol>)realTimeTHDataProtocol {
    return [[MKGWBXPSRealTimeTHDataPageModel alloc] init];
}

- (id <MKScannerBXPSHistoricalTHDataProtocol>)historicalTHDataProtocol {
    return [[MKGWBXPSHistoricalTHDataPageModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGWBXPSAccDataPageModel alloc] init];
}

- (id <MKScannerTHDataSampleRateProtocol>)sampleRateProtocol {
    return [[MKGWBXPSTHDataSampleRateModel alloc] init];
}

- (id <MKScannerBXPSHallCountProtocol>)hallCountProtocol {
    return [[MKGWBXPSHallCountPageModel alloc] init];
}

- (id <MKScannerBXPSReminderProtocol>)remoteReminderProtocol {
    return [[MKGWBXPSRemoteReminderModel alloc] init];
}

- (id <MKScannerBXPSAdvParamsProtocol>)advProtocol {
    return [[MKGWBXPSAdvParamsModel alloc] init];
}


- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPSConnectedStatusWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
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
    [MKGWMQTTInterface gw_bxpBXPSPowerOffWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
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
