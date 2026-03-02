//
//  MKGWDeviceModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWDeviceModel.h"

#import "MKMacroDefines.h"

#import "MKGWMQTTDataManager.h"

@implementation MKGWDeviceModel

- (void)dealloc{
    NSLog(@"MKGWDeviceModel销毁");
}

- (NSString *)currentSubscribedTopic {
    if (ValidStr([MKGWMQTTDataManager shared].serverParams.publishTopic)) {
        return [MKGWMQTTDataManager shared].serverParams.publishTopic;
    }
    return self.subscribedTopic;
}

- (NSString *)currentPublishedTopic {
    if (ValidStr([MKGWMQTTDataManager shared].serverParams.subscribeTopic)) {
        return [MKGWMQTTDataManager shared].serverParams.subscribeTopic;
    }
    return self.publishedTopic;
}

@end
