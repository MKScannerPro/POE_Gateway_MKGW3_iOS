//
//  MKScannerBXPCController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerBXPCProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBXPCController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerBXPCProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
