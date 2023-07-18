//
//  MKGWMqttServerLwtView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWMqttServerLwtViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKGWMqttServerLwtViewDelegate <NSObject>

- (void)gw_lwt_statusChanged:(BOOL)isOn;

- (void)gw_lwt_retainChanged:(BOOL)isOn;

- (void)gw_lwt_qosChanged:(NSInteger)qos;

- (void)gw_lwt_topicChanged:(NSString *)text;

- (void)gw_lwt_payloadChanged:(NSString *)text;

@end

@interface MKGWMqttServerLwtView : UIView

@property (nonatomic, strong)MKGWMqttServerLwtViewModel *dataModel;

@property (nonatomic, weak)id <MKGWMqttServerLwtViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
