//
//  MKScannerTofSensorDataController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerTofSensorDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerTofSensorDataController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerTofSensorDataProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
