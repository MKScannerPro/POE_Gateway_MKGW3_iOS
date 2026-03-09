//
//  MKScannerDeviceInfoController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerDeviceInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerDeviceInfoController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerDeviceInfoProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
