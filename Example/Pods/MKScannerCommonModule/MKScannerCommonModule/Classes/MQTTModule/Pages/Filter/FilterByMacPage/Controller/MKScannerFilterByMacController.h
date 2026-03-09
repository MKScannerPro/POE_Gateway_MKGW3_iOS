//
//  MKScannerFilterByMacController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerFilterByMacProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerFilterByMacController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerFilterByMacProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
