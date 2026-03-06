//
//  MKGWBXPSRealTimeTHDataPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPSRealTimeTHDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPSRealTimeTHDataPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPSRealTimeTHDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _mailFileName = @"BXP-S RealTimeHTDatas.txt";
    }
    return self;
}

- (void)notifyRealTimeHTData:(BOOL)isOn
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBXPSNotifyRealTimeHTDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                         notify:isOn
                                                     macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                          topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                       sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveHTDatas:)
                                                         name:MKGWReceiveBXPSRealTimeHTDataNotification
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
    NSString *temperature = [NSString stringWithFormat:@"%@",dataDic[@"temperature"]];
    NSString *humidity = [NSString stringWithFormat:@"%@",dataDic[@"humidity"]];
    if (self.receiveHTDataBlock) {
        self.receiveHTDataBlock(temperature, humidity);
    }
}

@end
