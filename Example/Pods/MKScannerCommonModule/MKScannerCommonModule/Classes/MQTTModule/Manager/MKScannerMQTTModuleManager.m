//
//  MKScannerMQTTModuleManager.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerMQTTModuleManager.h"

#import "MKMacroDefines.h"

NSString *const mk_scanner_deviceOfflineNotification = @"mk_scanner_deviceOfflineNotification";
NSString *const mk_scanner_deviceLoadChangedNotification = @"mk_scanner_deviceLoadChangedNotification";

static MKScannerMQTTModuleManager *manager = nil;
static dispatch_once_t onceToken;

@implementation MKScannerMQTTModuleManager

- (instancetype)init {
    if (self = [super init]) {
        [self setupBlocks];
    }
    return self;
}

+ (MKScannerMQTTModuleManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKScannerMQTTModuleManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    manager = nil;
    onceToken = 0;
}

#pragma mark - Public method
- (void)setupBlocks {
    @weakify(self);
    self.deviceOfflineBlock = ^{
        @strongify(self);
        [[NSNotificationCenter  defaultCenter] postNotificationName:mk_scanner_deviceOfflineNotification
                                                             object:nil
                                                           userInfo:nil];
    };
    self.loadChangedBlock = ^(NSInteger state) {
        @strongify(self);
        [[NSNotificationCenter  defaultCenter] postNotificationName:mk_scanner_deviceLoadChangedNotification
                                                             object:nil
                                                           userInfo:@{@"state":@(state)}];
    };
}

@end
