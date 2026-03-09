//
//  MKScannerButtonDfuV1Controller.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerButtonDfuV1Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerButtonDfuV1Controller : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerButtonDfuV1Protocol>)protocol;

@end

NS_ASSUME_NONNULL_END
