//
//  MKGWBXPCHistoricalTHDataPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPCHistoricalTHDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPCHistoricalTHDataPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPCHistoricalTHDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifyHistoricalHTData:(BOOL)isOn
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBXPCNotifyHistoricalHTDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                           notify:isOn
                                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveHTDatas:)
                                                         name:MKGWReceiveBXPCHistoricalHTDataNotification
                                                       object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
        if (sucBlock) {
            sucBlock();
        }
    }
                                                      failedBlock:failedBlock];
}

- (void)deleteHistoricalHTDataWithSucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBXPCDeleteHistoricalHTDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                         sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                      failedBlock:failedBlock];
}

#pragma mark - Notes
- (void)receiveHTDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].bleMac]) {
        return;
    }
    
    if (self.receiveHTDataBlock) {
        self.receiveHTDataBlock([dataDic[@"timestamp"] longLongValue], [dataDic[@"temperature"] floatValue], [dataDic[@"humidity"] floatValue]);
    }
}

@end
