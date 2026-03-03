//
//  MKGWScannerModuleManager.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/3.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWScannerModuleManager.h"

#import "MKMacroDefines.h"

#import "MKScannerMQTTModuleManager.h"
#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"

static MKGWScannerModuleManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKGWScannerModuleManager

- (void)dealloc {
    NSLog(@"MKGWScannerModuleManager销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self addNotifications];
    }
    return self;
}

+ (MKGWScannerModuleManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGWScannerModuleManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

#pragma mark - note
- (void)deviceOffline:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"macAddress"]];
}

- (void)receiveDeviceLwtMessage:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

- (void)deviceResetByButton:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"])) {
        return;
    }
    [self processOfflineWithMacAddress:user[@"device_info"][@"mac"]];
}

#pragma mark - Private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOffline:)
                                                 name:MKScannerDeviceModelOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceLwtMessage:)
                                                 name:MKGWReceiveDeviceOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceResetByButton:)
                                                 name:MKGWReceiveDeviceResetByButtonNotification
                                               object:nil];
}

- (void)processOfflineWithMacAddress:(NSString *)macAddress {
    if (![macAddress isEqualToString:[MKScannerDeviceModelManager shared].macAddress]) {
        return;
    }
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_scanner_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    if ([MKScannerMQTTModuleManager shared].deviceOfflineBlock) {
        [MKScannerMQTTModuleManager shared].deviceOfflineBlock();
    }
}

@end
