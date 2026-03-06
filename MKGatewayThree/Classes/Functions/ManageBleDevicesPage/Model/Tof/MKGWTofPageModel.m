//
//  MKGWTofPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWTofPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

#import "MKGWButtonDFUV2Model.h"

#import "MKGWTofAccDataPageModel.h"
#import "MKGWTofAdvParamsModel.h"
#import "MKGWTofSensorDataPageModel.h"
#import "MKGWTofSensorParamsPageModel.h"


@implementation MKGWTofPageModel

- (void)dealloc {
    NSLog(@"MKGWTofPageModel销毁");
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

- (id <MKScannerTofAdvParamsProtocol>)advProtocol {
    return [[MKGWTofAdvParamsModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accDataProtocol {
    return [[MKGWTofAccDataPageModel alloc] init];
}

- (id <MKScannerTofSensorDataProtocol>)sensorDataProtocol {
    return [[MKGWTofSensorDataPageModel alloc] init];
}

- (id <MKScannerTofSensorParamsProtocol>)sensorParamsProtocol {
    return [[MKGWTofSensorParamsPageModel alloc] init];
}

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readMKTofConnectedStatusWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
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
    [MKGWMQTTInterface gw_bxpMKTofPowerOffWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
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
