//
//  MKScannerBaseController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKScannerMQTTModuleManager.h"

@interface MKScannerBaseController ()

@end

@implementation MKScannerBaseController

- (void)dealloc {
    NSLog(@"MKScannerBaseController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotifications];
}

#pragma mark - Notes
- (void)loadChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !user[@"state"]) {
        return;
    }
    
    NSString *message = ([user[@"state"] integerValue] == 1 ? @"Load start work!" : @"Load stop work!");
    [self.view showCentralToast:message];
}

#pragma mark - Private method
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOffline)
                                                 name:mk_scanner_deviceOfflineNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadChanged:)
                                                 name:mk_scanner_deviceLoadChangedNotification
                                               object:nil];
}

- (void)deviceOffline {
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [self.view showCentralToast:@"device is off-line"];
}

@end
