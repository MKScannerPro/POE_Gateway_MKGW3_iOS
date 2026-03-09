//
//  MKScannerBleBeaconController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/25.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKScannerBleBeaconProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleBeaconController : MKScannerBleBaseController

- (instancetype)initWithProtocol:(id<MKScannerBleBeaconProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
