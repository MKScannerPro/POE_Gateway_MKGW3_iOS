//
//  MKScannerCommunicateController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerCommunicateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerCommunicateController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerCommunicateProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
