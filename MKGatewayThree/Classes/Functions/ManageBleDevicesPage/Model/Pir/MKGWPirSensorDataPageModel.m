//
//  MKGWPirSensorDataPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWPirSensorDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWPirSensorDataPageModel

- (void)dealloc {
    NSLog(@"MKGWPirSensorDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notes
- (void)receiveSensorDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].bleMac]) {
        return;
    }
    NSString *doorState = ([dataDic[@"hall_status"] integerValue] == 1 ? @"Door open" : @"Door close");
    NSString *pirState = ([dataDic[@"pir_status"] integerValue] == 1 ? @"occupied" : @"not occupied");
    if (self.receiveSensorDataBlock) {
        self.receiveSensorDataBlock(doorState, pirState);
    }
}


#pragma mark - Public method
- (void)notifySensorData:(BOOL)isOn
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_notifyMKPirSensorDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                   notify:isOn
                                               macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                    topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                 sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveSensorDatas:)
                                                         name:MKGWReceiveMKPirSensorDataNotification
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

@end
