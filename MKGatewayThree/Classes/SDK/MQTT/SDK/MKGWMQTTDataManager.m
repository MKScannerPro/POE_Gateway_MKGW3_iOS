//
//  MKGWMQTTDataManager.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWMQTTDataManager.h"

#import "MKMacroDefines.h"

#import "MKGWMQTTServerManager.h"

#import "MKGWMQTTOperation.h"

NSString *const MKGWMQTTSessionManagerStateChangedNotification = @"MKGWMQTTSessionManagerStateChangedNotification";

NSString *const MKGWReceiveDeviceOnlineNotification = @"MKGWReceiveDeviceOnlineNotification";
NSString *const MKGWReceiveDeviceNetStateNotification = @"MKGWReceiveDeviceNetStateNotification";
NSString *const MKGWReceiveDeviceOTAResultNotification = @"MKGWReceiveDeviceOTAResultNotification";
NSString *const MKGWReceiveDeviceNpcOTAResultNotification = @"MKGWReceiveDeviceNpcOTAResultNotification";
NSString *const MKGWReceiveDeviceResetByButtonNotification = @"MKGWReceiveDeviceResetByButtonNotification";
NSString *const MKGWReceiveDeviceUpdateEapCertsResultNotification = @"MKGWReceiveDeviceUpdateEapCertsResultNotification";
NSString *const MKGWReceiveDeviceUpdateMqttCertsResultNotification = @"MKGWReceiveDeviceUpdateMqttCertsResultNotification";

NSString *const MKGWReceiveDeviceDatasNotification = @"MKGWReceiveDeviceDatasNotification";
NSString *const MKGWReceiveGatewayDisconnectBXPButtonNotification = @"MKGWReceiveGatewayDisconnectBXPButtonNotification";
NSString *const MKGWReceiveGatewayDisconnectDeviceNotification = @"MKGWReceiveGatewayDisconnectDeviceNotification";
NSString *const MKGWReceiveGatewayConnectedDeviceDatasNotification = @"MKGWReceiveGatewayConnectedDeviceDatasNotification";

NSString *const MKGWReceiveBxpButtonDfuProgressNotification = @"MKGWReceiveBxpButtonDfuProgressNotification";
NSString *const MKGWReceiveBxpButtonDfuResultNotification = @"MKGWReceiveBxpButtonDfuResultNotification";
NSString *const MKGWReceiveBxpDfuFailedNotification = @"MKGWReceiveBxpDfuFailedNotification";

NSString *const MKGWReceiveDeviceOfflineNotification = @"MKGWReceiveDeviceOfflineNotification";

NSString *const MKGWReceiveBXPBtnAccDataNotification = @"MKGWReceiveBXPBtnAccDataNotification";

NSString *const MKGWReceiveBXPBtnCRAccDataNotification = @"MKGWReceiveBXPBtnCRAccDataNotification";
NSString *const MKGWReceiveBXPBtnCRAlarmEventDataNotification = @"MKGWReceiveBXPBtnCRAlarmEventDataNotification";

NSString *const MKGWReceiveBXPCRealTimeHTDataNotification = @"MKGWReceiveBXPCRealTimeHTDataNotification";
NSString *const MKGWReceiveBXPCAccDataNotification = @"MKGWReceiveBXPCAccDataNotification";
NSString *const MKGWReceiveBXPCHistoricalHTDataNotification = @"MKGWReceiveBXPCHistoricalHTDataNotification";

NSString *const MKGWReceiveBXPDAccDataNotification = @"MKGWReceiveBXPDAccDataNotification";

NSString *const MKGWReceiveBXPTAccDataNotification = @"MKGWReceiveBXPTAccDataNotification";

NSString *const MKGWReceiveBXPSRealTimeHTDataNotification = @"MKGWReceiveBXPSRealTimeHTDataNotification";
NSString *const MKGWReceiveBXPSAccDataNotification = @"MKGWReceiveBXPSAccDataNotification";
NSString *const MKGWReceiveBXPSHistoricalHTDataNotification = @"MKGWReceiveBXPSHistoricalHTDataNotification";

NSString *const MKGWReceiveMKPirSensorDataNotification = @"MKGWReceiveMKPirSensorDataNotification";

NSString *const MKGWReceiveMKTofAccDataNotification = @"MKGWReceiveMKTofAccDataNotification";
NSString *const MKGWReceiveMKTofDistanceDataNotification = @"MKGWReceiveMKTofDistanceDataNotification";


static MKGWMQTTDataManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKGWMQTTDataManager ()

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKGWMQTTDataManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKGWMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKGWMQTTDataManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKGWMQTTDataManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKGWMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKGWServerManagerProtocol
- (void)gw_didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic {
    if (!ValidDict(data) || !ValidNum(data[@"msg_id"]) || !ValidStr(data[@"device_info"][@"mac"])) {
        return;
    }
    NSInteger msgID = [data[@"msg_id"] integerValue];
    NSString *macAddress = data[@"device_info"][@"mac"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceOnlineNotification
                                                        object:nil
                                                      userInfo:@{@"macAddress":macAddress}];
    if (msgID == 3004) {
        //上报的网络状态
        NSDictionary *resultDic = @{
            @"macAddress":macAddress,
            @"data":data[@"data"]
        };
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceNetStateNotification
                                                            object:nil
                                                          userInfo:resultDic];
        return;
    }
    if (msgID == 3007) {
        //固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3014) {
        //设备通过按键恢复出厂设置
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceResetByButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3016) {
        //NCP固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceNpcOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3022) {
        //EAP证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceUpdateEapCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3032) {
        //MQTT证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceUpdateMqttCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3070) {
        //扫描到的数据
        if ([self.dataDelegate respondsToSelector:@selector(mk_gw_receiveDeviceDatas:)]) {
            [self.dataDelegate mk_gw_receiveDeviceDatas:data];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3108) {
        //网关与已连接的BXP-Button设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveGatewayDisconnectBXPButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3117) {
        //BXP-B-D 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPBtnAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3166) {
        //BXP-B-CR 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPBtnCRAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3173) {
        //BXP-B-CR 触发记录数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPBtnCRAlarmEventDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3203 || msgID == 3206) {
        //BXP-Button升级进度    3206是MKGW3 V2
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBxpButtonDfuProgressNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3204 || msgID == 3207) {
        //BXP-Button升级结果 3207是MKGW3 V2
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBxpButtonDfuResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3208) {
        //MKGW3 V2 dfu升级完成
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBxpDfuFailedNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3302) {
        //网关与已连接的蓝牙设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveGatewayDisconnectDeviceNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3311) {
        //网关接收到已连接的蓝牙设备的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveGatewayConnectedDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3358) {
        //BXP-C 实时温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPCRealTimeHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3361) {
        //BXP-C 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPCAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3364) {
        //BXP-C 历史温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPCHistoricalHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3416) {
        //BXP-D 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPDAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3468) {
        //BXP-T 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPTAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3508) {
        //BXP-S 实时温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPSRealTimeHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3511) {
        //BXP-S 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPSAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3514) {
        //BXP-S 历史温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveBXPSHistoricalHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3558) {
        //MK Pir传感器数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveMKPirSensorDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3608) {
        //MK Tof 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveMKTofAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3625) {
        //MK Tof 距离通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveMKTofDistanceDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3999) {
        //遗嘱，设备离线
        [[NSNotificationCenter defaultCenter] postNotificationName:MKGWReceiveDeviceOfflineNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKGWMQTTOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:data onTopic:topic];
                break;
            }
        }
    }
}

- (void)gw_didChangeState:(MKGWMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGWMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKGWMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKGWMQTTServerManager shared].serverParams.publishTopic;
}

- (id<MKGWServerParamsProtocol>)currentServerParams {
    return [MKGWMQTTServerManager shared].currentServerParams;
}

- (BOOL)saveServerParams:(id <MKGWServerParamsProtocol>)protocol {
    return [[MKGWMQTTServerManager shared] saveServerParams:protocol];
}

- (BOOL)clearLocalData {
    return [[MKGWMQTTServerManager shared] clearLocalData];
}

- (BOOL)connect {
    return [[MKGWMQTTServerManager shared] connect];
}

- (void)disconnect {
    if (self.operationQueue.operations.count > 0) {
        [self.operationQueue cancelAllOperations];
    }
    [[MKGWMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKGWMQTTServerManager shared] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKGWMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)clearAllSubscriptions {
    [[MKGWMQTTServerManager shared] clearAllSubscriptions];
}

- (MKGWMQTTSessionManagerState)state {
    return [MKGWMQTTServerManager shared].state;
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gw_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKGWMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_gw_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKGWMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    operation.operationTimeout = timeout;
    [self.operationQueue addOperation:operation];
}

#pragma mark - private method

- (MKGWMQTTOperation *)generateOperationWithTaskID:(mk_gw_serverOperationID)taskID
                                              topic:(NSString *)topic
                                        macAddress:(NSString *)macAddress
                                               data:(NSDictionary *)data
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidDict(data)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MQTT Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKGWMQTTOperation *operation = [[MKGWMQTTOperation alloc] initOperationWithID:taskID macAddress:macAddress commandBlock:^{
        [[MKGWMQTTServerManager shared] sendData:data topic:topic sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.RGMQTTDataManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

#pragma mark - getter
- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

@end
