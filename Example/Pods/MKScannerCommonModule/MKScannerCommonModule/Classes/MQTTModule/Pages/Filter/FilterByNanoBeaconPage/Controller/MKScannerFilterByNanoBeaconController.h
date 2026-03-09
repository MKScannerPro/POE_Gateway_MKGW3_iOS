//
//  MKScannerFilterByNanoBeaconController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerFilterByNanoBeaconProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerFilterByNanoBeaconController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerFilterByNanoBeaconProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
