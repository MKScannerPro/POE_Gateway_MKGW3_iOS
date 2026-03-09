//
//  MKScannerFilterByAdvNameController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerFilterByAdvNameProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerFilterByAdvNameController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerFilterByAdvNameProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
