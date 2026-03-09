//
//  MKScannerDeviceModelManager.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerDeviceModelManager.h"

#import "MKMacroDefines.h"


static MKScannerDeviceModelManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKScannerDeviceModelManager ()

@property (nonatomic, strong)MKScannerDeviceModel *deviceModel;

@end

@implementation MKScannerDeviceModelManager

+ (MKScannerDeviceModelManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKScannerDeviceModelManager new];
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
    if (!self.deviceModel) {
        return @"";
    }
    return SafeStr(self.deviceModel.macAddress);
}

/// 当前设备的订阅主题
- (NSString *)subscribedTopic {
    if (!self.deviceModel) {
        return @"";
    }
    return [self.deviceModel currentSubscribedTopic];
}

- (NSString *)deviceName {
    if (!self.deviceModel) {
        return @"";
    }
    return self.deviceModel.deviceName;
}

- (void)addDeviceModel:(MKScannerDeviceModel *)deviceModel {
    self.deviceModel = nil;
    self.deviceModel = deviceModel;
}

- (void)clearDeviceModel {
    if (self.deviceModel) {
        self.deviceModel = nil;
    }
}

- (void)updateDeviceName:(NSString *)deviceName {
    if (!ValidStr(deviceName)) {
        return;
    }
    self.deviceModel.deviceName = SafeStr(deviceName);
}

@end
