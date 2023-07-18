//
//  MKGWMQTTLWTForDeviceView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWMQTTLWTForDeviceViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKGWMQTTLWTForDeviceViewDelegate <NSObject>

- (void)gw_lwt_statusChanged:(BOOL)isOn;

- (void)gw_lwt_retainChanged:(BOOL)isOn;

- (void)gw_lwt_qosChanged:(NSInteger)qos;

- (void)gw_lwt_topicChanged:(NSString *)text;

- (void)gw_lwt_payloadChanged:(NSString *)text;

@end

@interface MKGWMQTTLWTForDeviceView : UIView

@property (nonatomic, strong)MKGWMQTTLWTForDeviceViewModel *dataModel;

@property (nonatomic, weak)id <MKGWMQTTLWTForDeviceViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
