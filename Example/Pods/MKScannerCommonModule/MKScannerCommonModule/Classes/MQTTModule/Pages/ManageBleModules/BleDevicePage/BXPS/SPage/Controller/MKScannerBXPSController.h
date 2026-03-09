//
//  MKScannerBXPSController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerBXPSProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBXPSController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerBXPSProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
