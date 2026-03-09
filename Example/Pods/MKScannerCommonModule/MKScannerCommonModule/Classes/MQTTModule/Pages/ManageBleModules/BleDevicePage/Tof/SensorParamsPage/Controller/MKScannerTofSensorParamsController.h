//
//  MKScannerTofSensorParamsController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerTofSensorParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerTofSensorParamsController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerTofSensorParamsProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
