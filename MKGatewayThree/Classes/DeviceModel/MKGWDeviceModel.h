//
//  MKGWDeviceModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGWDeviceModeManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGWDeviceModelState) {
    MKGWDeviceModelStateOffline,
    MKGWDeviceModelStateOnline,
};

//当设备离线的时候发出通知
extern NSString *const MKGWDeviceModelOfflineNotification;

@protocol MKGWDeviceModelDelegate <NSObject>

/// 当前设备离线
/// @param macAddress 当前设备的macAddress
- (void)gw_deviceOfflineWithMacAddress:(NSString *)macAddress;

@end

@interface MKGWDeviceModel : NSObject<MKGWDeviceModeManagerDataProtocol>

/// 设备类型 00:V1固件    01:V2固件
@property (nonatomic, copy)NSString *deviceType;

/// 0:ethernet   1:wifi 2:ETH->WIFI 3:WIFI->ETH
@property (nonatomic, copy)NSString *networkType;

/// MQTT通信所需的ID，如果存在重复的，会出现交替上线的情况
@property (nonatomic, copy)NSString *clientID;

/**
 设备广播名字
 */
@property (nonatomic, copy)NSString *deviceName;

/**
 订阅主题
 */
@property (nonatomic, copy)NSString *subscribedTopic;

/**
 发布主题
 */
@property (nonatomic, copy)NSString *publishedTopic;

/**
 mac地址，注意此处用的是wifi的mac而非ble的
 */
@property (nonatomic, copy)NSString *macAddress;

/// 遗言是否打开，如果用户设置了遗言topic，则也需要订阅
@property (nonatomic, assign)BOOL lwtStatus;

/// 遗言topic，如果用户设置了遗言topic，则也需要订阅
@property (nonatomic, copy)NSString *lwtTopic;

/**
 设备的状态，离线、在线
 */
@property (nonatomic, assign)MKGWDeviceModelState onLineState;

#pragma mark - 业务流程相关

@property (nonatomic, weak)id <MKGWDeviceModelDelegate>delegate;

/**
 当前model的订阅主题，当用户设置了app的订阅主题时，返回设置的订阅主题，否则返回当前model的订阅主题
 
 @return subscribedTopic
 */
- (NSString *)currentSubscribedTopic;

/**
 当前model的发布主题，当用户设置了app的发布主题时，返回设置的发布主题，否则返回当前model的发布主题
 
 @return publishedTopic
 */
- (NSString *)currentPublishedTopic;

/**
 设备列表页面的状态监控
 */
- (void)startStateMonitoringTimer;

/**
 接收到开关状态的时候，需要清除离线状态计数
 */
- (void)resetTimerCounter;

/**
 取消定时器
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
