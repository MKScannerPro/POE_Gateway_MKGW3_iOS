//
//  MKScannerFilterByTagController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerFilterByTagProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerFilterByTagController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerFilterByTagProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
