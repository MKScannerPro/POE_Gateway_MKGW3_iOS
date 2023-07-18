//
//  MKGWDeviceMQTTParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MKGWDeviceModel;
@interface MKGWDeviceMQTTParamsModel : NSObject

@property (nonatomic, assign)BOOL wifiConfig;

@property (nonatomic, assign)BOOL mqttConfig;

@property (nonatomic, strong)MKGWDeviceModel *deviceModel;

+ (MKGWDeviceMQTTParamsModel *)shared;

+ (void)sharedDealloc;

@end

NS_ASSUME_NONNULL_END
