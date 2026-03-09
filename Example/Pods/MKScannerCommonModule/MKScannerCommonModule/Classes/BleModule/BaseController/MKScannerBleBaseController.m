//
//  MKScannerBleBaseController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

@interface MKScannerBleBaseController ()

@end

@implementation MKScannerBleBaseController

- (void)dealloc {
    NSLog(@"MKScannerBleBaseController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnect)
                                                 name:@"mk_scanner_peripheralDisconnectNotification"
                                               object:nil];
}

#pragma mark - note
- (void)disconnect {
    if (![MKBaseViewController isCurrentViewControllerVisible:self]) {
        return;
    }
    [self.view showCentralToast:@"Device disconnect!"];
}

@end
