//
//  MKGWDeviceMQTTParamsModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWDeviceMQTTParamsModel.h"

#import "MKGWDeviceModel.h"

static MKGWDeviceMQTTParamsModel *paramsModel = nil;
static dispatch_once_t onceToken;

@implementation MKGWDeviceMQTTParamsModel

+ (MKGWDeviceMQTTParamsModel *)shared {
    dispatch_once(&onceToken, ^{
        if (!paramsModel) {
            paramsModel = [MKGWDeviceMQTTParamsModel new];
        }
    });
    return paramsModel;
}

+ (void)sharedDealloc {
    paramsModel = nil;
    onceToken = 0;
}

#pragma mark - getter
- (MKGWDeviceModel *)deviceModel {
    if (!_deviceModel) {
        _deviceModel = [[MKGWDeviceModel alloc] init];
    }
    return _deviceModel;
}

@end
