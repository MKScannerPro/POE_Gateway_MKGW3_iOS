//
//  MKScannerBXPCAdvParamsController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerBXPCAdvParamsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBXPCAdvParamsController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerBXPCAdvParamsProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
