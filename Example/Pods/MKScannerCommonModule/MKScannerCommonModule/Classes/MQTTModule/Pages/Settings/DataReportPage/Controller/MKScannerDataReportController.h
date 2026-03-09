//
//  MKScannerDataReportController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerDataReportProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerDataReportController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerDataReportProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
