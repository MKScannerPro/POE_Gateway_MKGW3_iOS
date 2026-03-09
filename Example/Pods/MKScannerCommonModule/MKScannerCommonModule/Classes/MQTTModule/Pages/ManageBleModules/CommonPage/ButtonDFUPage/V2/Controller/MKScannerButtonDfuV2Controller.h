//
//  MKScannerButtonDfuV2Controller.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerButtonDfuV2Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerButtonDfuV2Controller : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerButtonDfuV2Protocol>)protocol;

@end

NS_ASSUME_NONNULL_END
