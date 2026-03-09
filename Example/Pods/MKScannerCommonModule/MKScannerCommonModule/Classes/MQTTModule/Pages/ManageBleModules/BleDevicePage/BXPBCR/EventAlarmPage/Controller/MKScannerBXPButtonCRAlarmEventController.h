//
//  MKScannerBXPButtonCRAlarmEventController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerBXPButtonCRAlarmEventProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBXPButtonCRAlarmEventController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerBXPButtonCRAlarmEventProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
