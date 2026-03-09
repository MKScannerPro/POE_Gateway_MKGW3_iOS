//
//  MKScannerBleNTPTimezoneController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKScannerBleNTPTimezoneProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleNTPTimezoneController : MKScannerBleBaseController

- (instancetype)initWithProtocol:(id<MKScannerBleNTPTimezoneProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
