//
//  MKScannerBleDeviceInfoController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKScannerBleDeviceInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleDeviceInfoController : MKScannerBleBaseController

- (instancetype)initWithProtocol:(id<MKScannerBleDeviceInfoProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
