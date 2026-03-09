//
//  MKScannerTofAdvParamsController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerTofAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerTofAdvParamsController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerTofAdvParamsProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
