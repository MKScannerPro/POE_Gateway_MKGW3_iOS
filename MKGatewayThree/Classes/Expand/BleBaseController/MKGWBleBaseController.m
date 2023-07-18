//
//  MKGWBleBaseController.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleBaseController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKGWCentralManager.h"

@interface MKGWBleBaseController ()

@end

@implementation MKGWBleBaseController

- (void)dealloc {
    NSLog(@"MKGWBleBaseController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_gw_peripheralConnectStateChangedNotification
                                               object:nil];
}

#pragma mark - note
- (void)deviceConnectStateChanged {
    if ([MKGWCentralManager shared].connectStatus == mk_gw_centralConnectStatusConnected) {
        return;
    }
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [self.view showCentralToast:@"Device disconnect!"];
    [self performSelector:@selector(gotoScanPage) withObject:nil afterDelay:0.5f];
}

#pragma mark - private method
- (void)gotoScanPage {
    [self popToViewControllerWithClassName:@"MKGWScanPageController"];
}

@end
