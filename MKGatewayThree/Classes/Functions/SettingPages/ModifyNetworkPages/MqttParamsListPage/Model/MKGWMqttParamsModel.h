//
//  MKGWMqttParamsModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/15.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWMqttParamsModel : NSObject

/// 0:Ethernet    1:WiFi
@property (nonatomic, copy)NSString *networkType;

@property (nonatomic, copy)NSString *clientID;

@property (nonatomic, copy)NSString *subscribeTopic;

@property (nonatomic, copy)NSString *publishTopic;

@property (nonatomic, assign)BOOL lwtStatus;

/// 只有配置了MQTT，该参数才需要更新本地
@property (nonatomic, copy)NSString *lwtTopic;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
