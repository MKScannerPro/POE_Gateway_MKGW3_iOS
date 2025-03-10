//
//  MKGWDeviceParamsListV2Controller.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/15.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleBaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDeviceParamsListV2Controller : MKGWBleBaseController

/// 初始状态，需要进入配网流程，如果是非初始状态，则不需要进入配网流程
@property (nonatomic, assign)BOOL originMode;

@end

NS_ASSUME_NONNULL_END
