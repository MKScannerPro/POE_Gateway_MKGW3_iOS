//
//  MKScannerMqttServerController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerMqttServerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerMqttServerController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerMqttServerProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
