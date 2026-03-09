//
//  MKScannerRealTimeTHDataController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerRealTimeTHDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerRealTimeTHDataController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerRealTimeTHDataProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
