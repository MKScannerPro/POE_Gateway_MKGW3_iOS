//
//  MKGWBXPTAccDataPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPTAccDataPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPTAccDataPageModel

- (void)dealloc {
    NSLog(@"MKGWBXPTAccDataPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _mailFileName = @"BXP-T AccData.txt";
    }
    return self;
}

#pragma mark - Notes
- (void)receiveAccDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].bleMac]) {
        return;
    }
    NSString *xAxisData = [NSString stringWithFormat:@"%@",dataDic[@"x_axis_data"]];
    NSString *yAxisData = [NSString stringWithFormat:@"%@",dataDic[@"y_axis_data"]];
    NSString *zAxisData = [NSString stringWithFormat:@"%@",dataDic[@"z_axis_data"]];
    if (self.receiveAccDataBlock) {
        self.receiveAccDataBlock(xAxisData, yAxisData, zAxisData);
    }
}


#pragma mark - Public method

/// 监听Acc数据
- (void)notifyAccData:(BOOL)isOn
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_bxpBXPTNotifyAccDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                  notify:isOn
                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:^(id  _Nonnull returnData) {
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveAccDatas:)
                                                         name:MKGWReceiveBXPTAccDataNotification
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
