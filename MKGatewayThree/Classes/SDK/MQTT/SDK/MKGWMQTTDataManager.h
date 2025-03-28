//
//  MKGWMQTTDataManager.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGWServerConfigDefines.h"

#import "MKGWMQTTTaskID.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MKGWMQTTSessionManagerStateChangedNotification;

extern NSString *const MKGWReceiveDeviceOnlineNotification;

extern NSString *const MKGWReceiveDeviceOTAResultNotification;

extern NSString *const MKGWReceiveDeviceNpcOTAResultNotification;

extern NSString *const MKGWReceiveDeviceResetByButtonNotification;

extern NSString *const MKGWReceiveDeviceUpdateEapCertsResultNotification;

extern NSString *const MKGWReceiveDeviceUpdateMqttCertsResultNotification;

extern NSString *const MKGWReceiveDeviceNetStateNotification;

extern NSString *const MKGWReceiveDeviceDatasNotification;

extern NSString *const MKGWReceiveGatewayDisconnectBXPButtonNotification;

extern NSString *const MKGWReceiveGatewayDisconnectDeviceNotification;

extern NSString *const MKGWReceiveGatewayConnectedDeviceDatasNotification;

extern NSString *const MKGWReceiveBxpButtonDfuProgressNotification;

extern NSString *const MKGWReceiveBxpButtonDfuResultNotification;


extern NSString *const MKGWReceiveDeviceOfflineNotification;

extern NSString *const MKGWReceiveBXPBtnAccDataNotification;

extern NSString *const MKGWReceiveBXPBtnCRAccDataNotification;

extern NSString *const MKGWReceiveBXPCRealTimeHTDataNotification;

extern NSString *const MKGWReceiveBXPCAccDataNotification;

extern NSString *const MKGWReceiveBXPBtnCRAlarmEventDataNotification;

extern NSString *const MKGWReceiveBXPCHistoricalHTDataNotification;

extern NSString *const MKGWReceiveBXPDAccDataNotification;

extern NSString *const MKGWReceiveBXPTAccDataNotification;

extern NSString *const MKGWReceiveBXPSRealTimeHTDataNotification;

extern NSString *const MKGWReceiveBXPSAccDataNotification;

extern NSString *const MKGWReceiveBXPSHistoricalHTDataNotification;

extern NSString *const MKGWReceiveMKPirSensorDataNotification;

extern NSString *const MKGWReceiveMKTofAccDataNotification;

extern NSString *const MKGWReceiveMKTofDistanceDataNotification;

@protocol MKGWReceiveDeviceDatasDelegate <NSObject>

- (void)mk_gw_receiveDeviceDatas:(NSDictionary *)data;

@end

@interface MKGWMQTTDataManager : NSObject<MKGWServerManagerProtocol>

@property (nonatomic, weak)id <MKGWReceiveDeviceDatasDelegate>dataDelegate;

@property (nonatomic, assign, readonly)MKGWMQTTSessionManagerState state;

+ (MKGWMQTTDataManager *)shared;

+ (void)singleDealloc;

/// 当前app连接服务器参数
@property (nonatomic, strong, readonly, getter=currentServerParams)id <MKGWServerParamsProtocol>serverParams;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentSubscribeTopic)NSString *subscribeTopic;

/// 当前用户有没有设置MQTT的订阅topic，如果设置了，则只能定于这个topic，如果没有设置，则订阅添加的设备的topic
@property (nonatomic, copy, readonly, getter=currentPublishedTopic)NSString *publishedTopic;

/// 将参数保存到本地，下次启动通过该参数连接服务器
/// @param protocol protocol
- (BOOL)saveServerParams:(id <MKGWServerParamsProtocol>)protocol;

/**
 清除本地记录的设置信息
 */
- (BOOL)clearLocalData;

#pragma mark - *****************************服务器交互部分******************************

/// 开始连接服务器，前提是必须服务器参数不能为空
- (BOOL)connect;

- (void)disconnect;

/**
 Subscribe the topic

 @param topicList topicList
 */
- (void)subscriptions:(NSArray <NSString *>*)topicList;

/**
 Unsubscribe the topic
 
 @param topicList topicList
 */
- (void)unsubscriptions:(NSArray <NSString *>*)topicList;

- (void)clearAllSubscriptions;

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param macAddress macAddress,6字节16进制，不包含任何符号AABBCCDDEEFF
/// @param taskID taskID
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gw_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

/// Send Data
/// @param data json
/// @param topic topic,1-128 Characters
/// @param macAddress macAddress,6字节16进制，不包含任何符号AABBCCDDEEFF
/// @param taskID taskID
/// @param timeout 任务超时时间
/// @param sucBlock Success callback
/// @param failedBlock Failed callback
- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gw_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
