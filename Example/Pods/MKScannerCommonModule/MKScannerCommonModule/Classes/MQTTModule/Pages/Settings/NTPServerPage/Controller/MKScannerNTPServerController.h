//
//  MKScannerNTPServerController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerNTPServerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerNTPServerController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerNTPServerProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
