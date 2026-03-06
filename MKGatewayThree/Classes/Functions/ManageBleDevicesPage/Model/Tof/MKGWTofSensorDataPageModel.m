//
//  MKGWTofSensorDataPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWTofSensorDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWTofSensorDataPageModel

- (void)dealloc {
    NSLog(@"MKGWTofSensorDataPageModel销毁");
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
    NSString *distance = [NSString stringWithFormat:@"%@",dataDic[@"distance"]];
    if (self.receiveSensorDataBlock) {
        self.receiveSensorDataBlock(distance);
    }
}


#pragma mark - Public method
- (void)notifySensorData:(BOOL)isOn
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpMKTofNotifySensorDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                      notify:isOn
                                                  macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                       topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveSensorDatas:)
                                                         name:MKGWReceiveMKTofDistanceDataNotification
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
