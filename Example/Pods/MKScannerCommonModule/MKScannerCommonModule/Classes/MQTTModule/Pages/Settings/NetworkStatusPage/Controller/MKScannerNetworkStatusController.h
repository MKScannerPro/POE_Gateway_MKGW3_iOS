//
//  MKScannerNetworkStatusController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerNetworkStatusProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerNetworkStatusController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerNetworkStatusProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
