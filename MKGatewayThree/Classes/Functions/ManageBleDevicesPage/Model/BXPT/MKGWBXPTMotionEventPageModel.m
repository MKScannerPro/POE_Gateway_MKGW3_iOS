//
//  MKGWBXPTMotionEventPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPTMotionEventPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWBXPTMotionEventPageModel

- (void)readDataWithSucBlock:(void (^)(NSString *count))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPTMotioEventCountWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                          sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            if (failedBlock) {
                NSError *error = [[NSError alloc] initWithDomain:@"BXPTMotionEventPageModel"
                                                            code:-999
                                                        userInfo:@{@"errorInfo":@"Read Failed"}];
                failedBlock(error);
            }
            return;
        }
        NSString *count = [NSString stringWithFormat:@"%@",returnData[@"data"][@"count"]];
        if (sucBlock) {
            sucBlock(count);
        }
    }
                                                       failedBlock:failedBlock];
}

- (void)clearHallCountWithSucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_clearBXPTMotioEventCountWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                         macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                              topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                        failedBlock:failedBlock];
}

@end
