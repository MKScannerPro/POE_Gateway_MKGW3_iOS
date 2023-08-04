//
//  MKGWDeviceListModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDeviceListModel : MKGWDeviceModel

/// 当前网络为WIFI的情况下有效
@property (nonatomic, assign)NSInteger wifiLevel;

@end

NS_ASSUME_NONNULL_END
