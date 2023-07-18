//
//  MKGWDeviceModeManager.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWDeviceModeManager.h"

#import "MKMacroDefines.h"


static MKGWDeviceModeManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKGWDeviceModeManager ()

@property (nonatomic, strong)id <MKGWDeviceModeManagerDataProtocol>protocol;

@end

@implementation MKGWDeviceModeManager

+ (MKGWDeviceModeManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGWDeviceModeManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

#pragma mark - public method

/// 当前设备的mac地址
- (NSString *)macAddress {
    if (!self.protocol) {
        return @"";
    }
    return SafeStr(self.protocol.macAddress);
}

/// 当前设备的订阅主题
- (NSString *)subscribedTopic {
    if (!self.protocol) {
        return @"";
    }
    return [self.protocol currentSubscribedTopic];
}

- (NSString *)deviceName {
    if (!self.protocol) {
        return @"";
    }
    return self.protocol.deviceName;
}

- (void)addDeviceModel:(id <MKGWDeviceModeManagerDataProtocol>)protocol {
    self.protocol = nil;
    self.protocol = protocol;
}

- (void)clearDeviceModel {
    if (self.protocol) {
        self.protocol = nil;
    }
}

- (void)updateDeviceName:(NSString *)deviceName {
    if (!ValidStr(deviceName)) {
        return;
    }
    self.protocol.deviceName = SafeStr(deviceName);
}

@end
