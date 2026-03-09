//
//  MKScannerAccDataController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerAccDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerAccDataController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerAccDataProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
