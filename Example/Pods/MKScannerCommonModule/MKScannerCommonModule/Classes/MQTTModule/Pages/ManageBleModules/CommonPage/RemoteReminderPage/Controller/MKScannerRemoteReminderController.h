//
//  MKScannerRemoteReminderController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerRemoteReminderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerRemoteReminderController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerRemoteReminderProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
