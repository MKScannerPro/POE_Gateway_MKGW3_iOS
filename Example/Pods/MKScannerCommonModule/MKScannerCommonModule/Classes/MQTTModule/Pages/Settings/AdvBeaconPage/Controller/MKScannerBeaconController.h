//
//  MKScannerBeaconController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/25.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerBeaconProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBeaconController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerBeaconProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
