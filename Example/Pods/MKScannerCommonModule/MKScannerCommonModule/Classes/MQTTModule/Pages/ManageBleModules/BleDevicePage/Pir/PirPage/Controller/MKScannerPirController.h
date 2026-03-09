//
//  MKScannerPirController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerPirProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerPirController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerPirProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
