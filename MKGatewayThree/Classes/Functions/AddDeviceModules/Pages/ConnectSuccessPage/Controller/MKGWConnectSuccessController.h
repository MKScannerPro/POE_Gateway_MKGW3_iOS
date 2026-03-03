//
//  MKGWConnectSuccessController.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKScannerCommonModule/MKScannerBaseController.h>

NS_ASSUME_NONNULL_BEGIN

@class MKGWDeviceModel;
@interface MKGWConnectSuccessController : MKScannerBaseController

@property (nonatomic, strong)MKGWDeviceModel *deviceModel;

@end

NS_ASSUME_NONNULL_END
