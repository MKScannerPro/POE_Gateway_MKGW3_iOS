//
//  MKScannerBXPButtonCRController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerBXPButtonCRProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBXPButtonCRController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerBXPButtonCRProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
