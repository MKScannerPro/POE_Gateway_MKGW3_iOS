//
//  Target_ScannerPro_GW3_Module.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/16.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "Target_ScannerPro_GW3_Module.h"

#import "MKGWDeviceListController.h"

@implementation Target_ScannerPro_GW3_Module

- (UIViewController *)Action_MKScannerPro_GW3_DeviceListPage:(NSDictionary *)params {
    MKGWDeviceListController *vc = [[MKGWDeviceListController alloc] init];
    vc.connectServer = YES;
    return vc;
}

@end
