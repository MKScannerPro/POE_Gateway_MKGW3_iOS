//
//  MKGWManageBleDevicesManager.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWManageBleDevicesManager.h"

#import "MKMacroDefines.h"

static MKGWManageBleDevicesManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKGWManageBleDevicesManager

+ (MKGWManageBleDevicesManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGWManageBleDevicesManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

- (NSString *)bleMac {
    if (!ValidDict(self.deviceBleInfo)) {
        return @"";
    }
    return self.deviceBleInfo[@"data"][@"mac"];
}

- (void)setDeviceBleInfo:(NSDictionary *)deviceBleInfo {
    _deviceBleInfo = nil;
    _deviceBleInfo = deviceBleInfo;
}

@end
