//
//  MKGWBXPCPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPCPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

#import "MKGWButtonDFUV2Model.h"

#import "MKGWBXPCAccDataPageModel.h"
#import "MKGWBXPCHistoricalTHDataPageModel.h"
#import "MKGWBXPCRealTimeTHDataPageModel.h"
#import "MKGWBXPCTHDataSampleRateModel.h"
#import "MKGWBXPCAdvParamsModel.h"


@implementation MKGWBXPCPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPCPageModel销毁");
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

- (id <MKScannerRealTimeTHDataProtocol>)realTimeTHProtocol {
    return [[MKGWBXPCRealTimeTHDataPageModel alloc] init];
}

- (id <MKScannerBXPCHistoricalTHDataProtocol>)historicalTHDataProtocol {
    return [[MKGWBXPCHistoricalTHDataPageModel alloc] init];
}

- (id <MKScannerAccDataProtocol>)accProtocol {
    return [[MKGWBXPCAccDataPageModel alloc] init];
}

- (id <MKScannerTHDataSampleRateProtocol>)sampleRateProtocol {
    return [[MKGWBXPCTHDataSampleRateModel alloc] init];
}

- (id <MKScannerBXPDAdvParamsProtocol>)advProtocol {
    return [[MKGWBXPCAdvParamsModel alloc] init];
}

- (void)readConnectedStatusWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPCConnectedStatusWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
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
    [MKGWMQTTInterface gw_bxpBXPCPowerOffWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
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
