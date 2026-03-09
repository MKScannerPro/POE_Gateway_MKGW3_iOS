//
//  MKScannerOTAController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerOTAProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerOTAController : MKBaseViewController

- (instancetype)initWithProtocol:(id<MKScannerOTAProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
