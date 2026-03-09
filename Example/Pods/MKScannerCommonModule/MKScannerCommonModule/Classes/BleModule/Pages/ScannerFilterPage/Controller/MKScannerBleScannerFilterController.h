//
//  MKScannerBleScannerFilterController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKScannerBleScannerFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleScannerFilterController : MKScannerBleBaseController

- (instancetype)initWithProtocol:(id<MKScannerBleScannerFilterProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
