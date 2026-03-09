//
//  MKScannerDataUploadIntervalController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBaseController.h"

#import "MKScannerDataUploadIntervalProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerDataUploadIntervalController : MKScannerBaseController

- (instancetype)initWithProtocol:(id<MKScannerDataUploadIntervalProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
