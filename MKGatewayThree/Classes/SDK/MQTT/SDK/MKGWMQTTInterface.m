//
//  MKGWMQTTInterface.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWMQTTInterface.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKGWMQTTDataManager.h"

@implementation MKGWMQTTInterface

#pragma mark *********************Config************************

+ (void)gw_rebootDeviceWithMacAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1000),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"reset":@(0),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskRebootDeviceOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configKeyResetType:(mk_gw_keyResetType)type
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1001),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"key_reset_type":@(type),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskKeyResetTypeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configNetworkStatusReportInterval:(NSInteger)interval
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 0 || (interval > 0 && interval < 30) || interval > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1003),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"report_interval":@(interval),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigNetworkStatusReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configReconnectTimeout:(NSInteger)timeout
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 0 || timeout > 1440) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1005),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(timeout),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigReconnectTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configOTAWithFilePath:(NSString *)filePath
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(filePath) || filePath.length > 256 || ![filePath isAsciiString]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1006),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"firmware_url":filePath
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigOTAHostOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configNTPServer:(BOOL)isOn
                      host:(NSString *)host
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!host || ![host isKindOfClass:NSString.class] || host.length > 64) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1008),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"server":SafeStr(host),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigNTPServerOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configDeviceTimeZone:(NSInteger)timeZone
                      timestamp:(NSTimeInterval)timestamp
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (timeZone < -24 || timeZone > 28) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1009),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timestamp":@(timestamp),
                @"timezone":@(timeZone)
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigDeviceTimeZoneOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configCommunicationTimeout:(NSInteger)timeout
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 0 || timeout > 60) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1010),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(timeout),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigCommunicationTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configIndicatorLightStatus:(id <gw_indicatorLightStatusProtocol>)protocol
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![protocol conformsToProtocol:@protocol(gw_indicatorLightStatusProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1011),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"net_led":(protocol.network_indicator ? @(1) : @(0)),
            @"sys_led":(protocol.system_indicator ? @(1) : @(0)),
            @"server_led":(protocol.server_indicator ? @(1) : @(0)),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigIndicatorLightStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_resetDeviceWithMacAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1013),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"factory_reset":@(0),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskResetDeviceOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configNpcOTAWithFilePath:(NSString *)filePath
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(filePath) || filePath.length > 256 || ![filePath isAsciiString]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1015),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"firmware_url":filePath
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigNpcOTAHostOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_modifyWifiInfos:(id <mk_gw_mqttModifyWifiProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmWifiProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1020),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"security_type":@(protocol.security),
                @"ssid":SafeStr(protocol.ssid),
                @"passwd":SafeStr(protocol.wifiPassword),
                @"eap_type":@(protocol.eapType),
                @"eap_id":SafeStr(protocol.domainID),
                @"eap_username":SafeStr(protocol.eapUserName),
                @"eap_passwd":SafeStr(protocol.eapPassword),
                @"eap_verify_server":(protocol.verifyServer ? @(1) : @(0))
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyWifiInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_modifyWifiCerts:(id <mk_gw_mqttModifyWifiEapCertProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmEAPCertProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1021),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"ca_url":SafeStr(protocol.caFilePath),
                @"client_cert_url":SafeStr(protocol.clientCertPath),
                @"client_key_url":SafeStr(protocol.clientKeyPath),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyWifiCertsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_modifyWifiNetworkInfos:(id <mk_gw_mqttModifyNetworkProtocol>)protocol
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmNetworkProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1023),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"dhcp_en":(protocol.dhcp ? @(1) : @(0)),
            @"ip":SafeStr(protocol.ip),
            @"netmask":SafeStr(protocol.mask),
            @"gw":SafeStr(protocol.gateway),
            @"dns":SafeStr(protocol.dns),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyWifiNetworkInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_modifyNetworkType:(mk_gw_mqtt_networkType)type
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSDictionary *data = @{
        @"msg_id":@(1024),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"net_interface":@(type),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyNetworkTypeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_modifyEthernetNetworkInfos:(id <mk_gw_mqttModifyNetworkProtocol>)protocol
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmNetworkProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1025),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"dhcp_en":(protocol.dhcp ? @(1) : @(0)),
            @"ip":SafeStr(protocol.ip),
            @"netmask":SafeStr(protocol.mask),
            @"gw":SafeStr(protocol.gateway),
            @"dns":SafeStr(protocol.dns),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyEthernetNetworkInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}



+ (void)gw_modifyMqttInfos:(id <mk_gw_modifyMqttServerProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmMqttServerProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1030),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"security_type":@(protocol.connectMode),
            @"host":SafeStr(protocol.host),
            @"port":@([protocol.port integerValue]),
            @"client_id":SafeStr(protocol.clientID),
            @"username":SafeStr(protocol.userName),
            @"passwd":SafeStr(protocol.password),
            @"sub_topic":SafeStr(protocol.subscribeTopic),
            @"pub_topic":SafeStr(protocol.publishTopic),
            @"qos":@(protocol.qos),
            @"clean_session":(protocol.cleanSession ? @(1) : @(0)),
            @"keepalive":@([protocol.keepAlive integerValue]),
            @"lwt_en":(protocol.lwtStatus ? @(1) : @(0)),
            @"lwt_qos":@(protocol.lwtQos),
            @"lwt_retain":(protocol.lwtRetain ? @(1) : @(0)),
            @"lwt_topic":SafeStr(protocol.lwtTopic),
            @"lwt_payload":SafeStr(protocol.lwtPayload),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyMqttInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_modifyMqttCerts:(id <mk_gw_modifyMqttServerCertsProtocol>)protocol
                macAddress:(NSString *)macAddress
                     topic:(NSString *)topic
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmMqttServerCertsProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1031),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"ca_url":SafeStr(protocol.caFilePath),
                @"client_cert_url":SafeStr(protocol.clientCertPath),
                @"client_key_url":SafeStr(protocol.clientKeyPath),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskModifyMqttCertsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configScanSwitchStatus:(BOOL)isOn
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1040),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"scan_switch":(isOn ? @(1) : @(0)),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigScanSwitchStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterRelationship:(mk_gw_filterRelationship)relationship
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1041),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"relation":@(relationship),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterRelationshipsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByRSSI:(NSInteger)rssi
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (rssi > 0 || rssi < -127) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1042),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"rssi":@(rssi),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByRSSIOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByMacAddress:(nonnull NSArray <NSString *>*)macList
                       preciseMatch:(BOOL)preciseMatch
                      reverseFilter:(BOOL)reverseFilter
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!macList || ![macList isKindOfClass:NSArray.class] || macList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < macList.count; i ++) {
        NSString *tempString = macList[i];
        if (tempString.length < 2 || tempString.length > 12 || tempString.length % 2 != 0 || ![tempString regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1043),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"precise":(preciseMatch ? @(1) : @(0)),
            @"reverse":(reverseFilter ? @(1) : @(0)),
            @"mac":macList
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByMacAddressOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByADVName:(nonnull NSArray <NSString *>*)nameList
                    preciseMatch:(BOOL)preciseMatch
                   reverseFilter:(BOOL)reverseFilter
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!nameList || ![nameList isKindOfClass:NSArray.class] || nameList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < nameList.count; i ++) {
        NSString *tempString = nameList[i];
        if (!ValidStr(tempString) || tempString.length > 20 || ![tempString isAsciiString]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1044),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"precise":(preciseMatch ? @(1) : @(0)),
                @"reverse":(reverseFilter ? @(1) : @(0)),
                @"name":nameList
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByADVNameOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByBeacon:(BOOL)isOn
                       minMinor:(NSInteger)minMinor
                       maxMinor:(NSInteger)maxMinor
                       minMajor:(NSInteger)minMajor
                       maxMajor:(NSInteger)maxMajor
                           uuid:(NSString *)uuid
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (!uuid || ![uuid isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(uuid)) {
        if (![uuid regularExpressions:isHexadecimal] || uuid.length > 32 || uuid.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1046),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
            @"uuid":SafeStr(uuid),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByBeaconOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByUID:(BOOL)isOn
                 namespaceID:(NSString *)namespaceID
                  instanceID:(NSString *)instanceID
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!namespaceID || ![namespaceID isKindOfClass:NSString.class] || !instanceID || ![instanceID isKindOfClass:NSString.class]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(namespaceID)) {
        if (![namespaceID regularExpressions:isHexadecimal] || namespaceID.length > 20 || namespaceID.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    if (ValidStr(instanceID)) {
        if (![instanceID regularExpressions:isHexadecimal] || instanceID.length > 12 || instanceID.length % 2 != 0) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1047),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"namespace":SafeStr(namespaceID),
            @"instance":SafeStr(instanceID),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByUIDOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByURL:(BOOL)isOn
                         url:(NSString *)url
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!url || ![url isKindOfClass:NSString.class] || url.length > 37) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (ValidStr(url)) {
        if (![url isAsciiString]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1048),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"url":SafeStr(url),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByUrlOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByTLM:(BOOL)isOn
                         tlm:(mk_gw_filterByTLM)tlm
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1049),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"tlm_version":@(tlm),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByTLMOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterFilterBXPDeviceInfo:(BOOL)isOn
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1050),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterBXPDeviceInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterBXPAcc:(BOOL)isOn
                   macAddress:(NSString *)macAddress
                        topic:(NSString *)topic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1051),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterBXPAccOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterBXPTH:(BOOL)isOn
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1052),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(isOn ? @(1) : @(0)),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterBXPTHOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterBXPButton:(id <mk_gw_BLEFilterBXPButtonProtocol>)protocol
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1053),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"switch_value":(protocol.isOn ? @(1) : @(0)),
                @"single_press":(protocol.singlePressIsOn ? @(1) : @(0)),
                @"double_press":(protocol.doublePressIsOn ? @(1) : @(0)),
                @"long_press":(protocol.longPressIsOn ? @(1) : @(0)),
                @"abnormal_inactivity":(protocol.abnormalInactivityIsOn ? @(1) : @(0)),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterBXPButtonOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByTag:(BOOL)isOn
                preciseMatch:(BOOL)preciseMatch
               reverseFilter:(BOOL)reverseFilter
                   tagIDList:(NSArray <NSString *>*)tagIDList
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!tagIDList || ![tagIDList isKindOfClass:NSArray.class] || tagIDList.count > 10) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    for (NSInteger i = 0; i < tagIDList.count; i ++) {
        NSString *tempString = tagIDList[i];
        if (tempString.length < 2 || tempString.length > 12 || tempString.length % 2 != 0 || ![tempString regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1054),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"precise":(preciseMatch ? @(1) : @(0)),
            @"reverse":(reverseFilter ? @(1) : @(0)),
            @"tagid":tagIDList,
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByTagOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByPir:(id <mk_gw_BLEFilterPirProtocol>)protocol
                    minMinor:(NSInteger)minMinor
                    maxMinor:(NSInteger)maxMinor
                    minMajor:(NSInteger)minMajor
                    maxMajor:(NSInteger)maxMajor
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmPirPresenceProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMinor < 0 || minMinor > 65535 || maxMinor < minMinor || maxMinor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (minMajor < 0 || minMajor > 65535 || maxMajor < minMajor || maxMajor > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1055),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(protocol.isOn ? @(1) : @(0)),
            @"delay_response_status":@(protocol.delayRespneseStatus),
            @"door_status":@(protocol.doorStatus),
            @"sensor_sensitivity":@(protocol.sensorSensitivity),
            @"sensor_detection_status":@(protocol.sensorDetectionStatus),
            @"min_major":@(minMajor),
            @"max_major":@(maxMajor),
            @"min_minor":@(minMinor),
            @"max_minor":@(maxMinor),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByPirOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByOtherDatas:(BOOL)isOn
                       relationship:(mk_gw_filterByOther)relationship
                        rawDataList:(NSArray <mk_gw_BLEFilterRawDataProtocol>*)rawDataList
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!rawDataList || ![rawDataList isKindOfClass:NSArray.class] || rawDataList.count > 3) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 1 && relationship != mk_gw_filterByOther_A) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 2 && relationship != mk_gw_filterByOther_AB && relationship != mk_gw_filterByOther_AOrB) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    if (rawDataList.count == 3 && relationship != mk_gw_filterByOther_ABC && relationship != mk_gw_filterByOther_ABOrC && relationship != mk_gw_filterByOther_AOrBOrC) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSMutableArray *dicList = [NSMutableArray array];
    for (id <mk_gw_BLEFilterRawDataProtocol>protocol in rawDataList) {
        if (![self isConfirmRawFilterProtocol:protocol]) {
            [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
            return;
        }
        NSDictionary *dic = @{
            @"type":SafeStr(protocol.dataType),
            @"start":@(protocol.minIndex),
            @"end":@(protocol.maxIndex),
            @"raw_data":SafeStr(protocol.rawData),
        };
        [dicList addObject:dic];
    }
    NSDictionary *data = @{
        @"msg_id":@(1056),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"relation":@(relationship),
            @"rule":dicList,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByOtherDatasOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configDuplicateDataFilter:(mk_gw_duplicateDataFilter)filter
                              period:(long long)period
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (filter != mk_gw_duplicateDataFilter_none && (period < 1 || period > 86400)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1057),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"rule":@(filter),
            @"timeout":@(period),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigDuplicateDataFilterOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configDataReportTimeout:(NSInteger)timeout
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 100 || timeout > 3000) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1058),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"timeout":@(timeout),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigDataReportTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configUploadDataOption:(id <gw_uploadDataOptionProtocol>)protocol
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![protocol conformsToProtocol:@protocol(gw_uploadDataOptionProtocol)]) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:(protocol.timestamp ? @(1) : @(0)) forKey:@"timestamp"];
    [params setObject:(protocol.rawData_advertising ? @(1) : @(0)) forKey:@"adv_data"];
    if (protocol.isV2) {
        [params setObject:(protocol.parsed_data ? @(1) : @(0)) forKey:@"parse_adv_data"];
    }else {
        [params setObject:(protocol.rawData_response ? @(1) : @(0)) forKey:@"rsp_data"];
    }
    NSDictionary *data = @{
        @"msg_id":@(1059),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":params
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigUploadDataOptionOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByPHY:(mk_gw_PHYMode)phy
                  macAddress:(NSString *)macAddress
                       topic:(NSString *)topic
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1060),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"phy_filter":@(phy),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByPHYOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByTofList:(NSArray <NSString *>*)codeList
                            isOn:(BOOL)isOn
                      macAddress:(NSString *)macAddress
                           topic:(NSString *)topic
                        sucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (codeList.count > 10 || !codeList || ![codeList isKindOfClass:NSArray.class]) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    for (NSString * code in codeList) {
        if (code.length != 4 || ![code regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1062),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"mfg_code":codeList,
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByTofOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configUploadDataInterval:(NSInteger)interval
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 0 || interval > 86400) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1063),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"interval":@(interval),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigUploadDataIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configFilterByNanoBeacon:(BOOL)isOn
                            advType:(mk_gw_filterByNanoBeaconAdvType)advType
                  manufactureIDList:(NSArray <NSString *>*)manufactureIDList
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (manufactureIDList.count > 10 || !manufactureIDList || ![manufactureIDList isKindOfClass:NSArray.class]) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    for (NSString * code in manufactureIDList) {
        if (code.length != 4 || ![code regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
            return;
        }
    }
    NSDictionary *data = @{
        @"msg_id":@(1064),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(isOn ? @(1) : @(0)),
            @"adv_type":@(advType),
            @"mf_id":manufactureIDList
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigFilterByNanoBeaconOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_connectBXPButtonWithPassword:(NSString *)password
                                 bleMac:(NSString *)bleMacAddress
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1100),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectBXPButtonWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_disconnectNormalBleDeviceWithBleMac:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1200),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskDisconnectNormalBleDeviceWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_startBXPButtonDfuWithFirmwareUrl:(NSString *)firmwareUrl
                                    dataUrl:(NSString *)dataUrl
                                     bleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!firmwareUrl || firmwareUrl.length > 256 || !dataUrl || dataUrl.length > 256) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1202),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"firmware_url":SafeStr(firmwareUrl),
            @"init_data_url":SafeStr(dataUrl),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskStartBXPButtonDfuWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_connectNormalBleDeviceWithBleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1300),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectNormalBleDeviceWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_startBXPDfuWithBeaconType:(NSInteger)type
                         firmwareUrl:(NSString *)firmwareUrl
                             dataUrl:(NSString *)dataUrl
                             dfuList:(NSArray <NSDictionary *>*)dfuList
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (type < 1 || type > 8) {
        [self operationFailedBlockWithMsg:@"Dfu type error" failedBlock:failedBlock];
        return;
    }
    if (!ValidArray(dfuList)) {
        [self operationFailedBlockWithMsg:@"Dfu list cannot be empty" failedBlock:failedBlock];
        return;
    }
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSMutableArray *tempList = [NSMutableArray array];
    for (NSInteger i = 0; i < dfuList.count; i ++) {
        NSDictionary *dic = dfuList[i];
        NSString *mac = dic[@"mac"];
        if (!ValidStr(mac) || mac.length != 12 || ![mac regularExpressions:isHexadecimal]) {
            [self operationFailedBlockWithMsg:@"Mac error" failedBlock:failedBlock];
            return;
        }
        [tempList addObject:@{@"mac":mac,@"passwd":SafeStr(dic[@"password"])}];
    }
    if (!firmwareUrl || firmwareUrl.length > 256) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (type != 5 && type != 6 && !dataUrl || dataUrl.length > 256) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1205),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"beacon_type":@(type),
            @"firmware_url":SafeStr(firmwareUrl),
            @"init_data_url":SafeStr(dataUrl),
            @"ble_dev":tempList,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskStartBXPDfuWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************Read************************
+ (void)gw_readKeyResetTypeWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2001),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadKeyResetTypeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readDeviceInfoWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2002),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadDeviceInfoOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readNetworkStatusReportIntervalWithMacAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2003),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadNetworkStatusReportIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readNetworkReconnectTimeoutWithMacAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2005),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadNetworkReconnectTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readNTPServerWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2008),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadNTPServerOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readDeviceUTCTimeWithMacAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2009),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadDeviceUTCTimeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readCommunicateTimeoutWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2010),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadCommunicateTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readIndicatorLightStatusWithMacAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2011),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadIndicatorLightStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readOtaStatusWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2012),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadOtaStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readWifiInfosWithMacAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2020),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadWifiInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readWifiNetworkInfosWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2023),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadWifiNetworkInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readNetworkTypeWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2024),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadNetworkTypeOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readEthernetNetworkInfosWithMacAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2025),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadEthernetNetworkInfosOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMQTTParamsWithMacAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2030),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMQTTParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readScanSwitchStatusWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2040),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadScanSwitchStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterRelationshipWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2041),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterRelationshipsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByRSSIWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2042),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByRSSIOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByMacWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2043),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByMacOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByADVNameWithMacAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2044),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterADVNameRSSIOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByRawDataStatusWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2045),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByRawDataStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByBeaconWithMacAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2046),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByBeaconOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByUIDWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2047),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByUIDOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByUrlWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2048),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByUrlOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByTLMWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2049),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByTLMOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterBXPDeviceInfoStatusWithMacAddress:(NSString *)macAddress
                                                 topic:(NSString *)topic
                                              sucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2050),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterBXPDeviceInfoStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterBXPAccStatusWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2051),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterBXPAccStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterBXPTHStatusWithMacAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2052),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterBXPTHStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterBXPButtonWithMacAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2053),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterBXPButtonOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterBXPTagWithMacAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2054),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterBXPTagOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByPirWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2055),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByPirOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterOtherDatasWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2056),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterOtherDatasOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readDuplicateDataFilterDatasWithMacAddress:(NSString *)macAddress
                                                topic:(NSString *)topic
                                             sucBlock:(void (^)(id returnData))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2057),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadDuplicateDataFilterDatasOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readDataReportTimeoutWithMacAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2058),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadDataReportTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readUploadDataOptionWithMacAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2059),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadUploadDataOptionOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByPHYWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2060),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByPHYOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByTofWithMacAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2062),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByTofOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readUploadDataIntervalWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2063),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadUploadDataIntervalOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readFilterByNanoBeaconWithMacAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2064),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadFilterByNanoBeaconOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  BXP-B-D  ************************

+ (void)gw_readBXPButtonConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                                  macAddress:(NSString *)macAddress
                                                       topic:(NSString *)topic
                                                    sucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1102),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPButtonConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPButtonConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                              macAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1104),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPButtonStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_dismissBXPButtonAlarmStatusWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1106),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskDismissAlarmStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readGatewayBleConnectStatusWithMacAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2201),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadGatewayBleConnectStatusOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readNormalConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1303),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadNormalConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_notifyCharacteristic:(BOOL)notify
                  bleMacAddress:(NSString *)bleMacAddress
                    serviceUUID:(NSString *)serviceUUID
             characteristicUUID:(NSString *)characteristicUUID
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1305),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"service_uuid":serviceUUID,
            @"char_uuid":characteristicUUID,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyCharacteristicOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readCharacteristicValueWithBleMacAddress:(NSString *)bleMacAddress
                                        serviceUUID:(NSString *)serviceUUID
                                 characteristicUUID:(NSString *)characteristicUUID
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(serviceUUID) || ![serviceUUID regularExpressions:isHexadecimal] || serviceUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(characteristicUUID) || ![characteristicUUID regularExpressions:isHexadecimal] || characteristicUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1307),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"service_uuid":serviceUUID,
            @"char_uuid":characteristicUUID
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadCharacteristicValueOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_writeValueToDeviceWithBleMacAddress:(NSString *)bleMacAddress
                                         value:(NSString *)value
                                   serviceUUID:(NSString *)serviceUUID
                            characteristicUUID:(NSString *)characteristicUUID
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(value) || ![value regularExpressions:isHexadecimal] || value.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(serviceUUID) || ![serviceUUID regularExpressions:isHexadecimal] || serviceUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(characteristicUUID) || ![characteristicUUID regularExpressions:isHexadecimal] || characteristicUUID.length % 2 != 0) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1309),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"service_uuid":serviceUUID,
            @"char_uuid":characteristicUUID,
            @"payload":value
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskWriteCharacteristicValueOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readAdvertiseBeaconParamsWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2061),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadAdvertiseBeaconParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configAdvertiseBeaconParams:(id <gw_advertiseBeaconProtocol>)protocol
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmAdvBeaconProtocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1061),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(protocol.advertise ? @(1) : @(0)),
            @"major":@(protocol.major),
            @"minor":@(protocol.minor),
            @"uuid":SafeStr(protocol.uuid),
            @"adv_interval":@(protocol.advInterval),
            @"tx_power":@(protocol.txPower),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigAdvertiseBeaconParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configV2AdvertiseBeaconParams:(id <gw_advertiseBeaconV2Protocol>)protocol
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (![self isConfirmAdvBeaconV2Protocol:protocol]) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1061),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"switch_value":(protocol.advertise ? @(1) : @(0)),
            @"major":@(protocol.major),
            @"minor":@(protocol.minor),
            @"uuid":SafeStr(protocol.uuid),
            @"adv_interval":@(protocol.advInterval),
            @"tx_power":@(protocol.txPower),
            @"rssi_1m":@(protocol.rssi1M),
            @"connectable":(protocol.connectable ? @(1) : @(0))
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigAdvertiseBeaconParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_clearTriggerEventCount:(mk_gw_triggerEventType)eventType
                           bleMac:(NSString *)bleMacAddress
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1113),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"type":@(eventType),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskClearTriggerEventCountOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnLedRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                blinkingTime:(NSInteger)blinkingTime
                            blinkingInterval:(NSInteger)blinkingInterval
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (blinkingTime < 1 || blinkingTime > 6000 || blinkingInterval < 0 || blinkingInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1109),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"flash_time":@(blinkingTime),
            @"flash_interval":@(blinkingInterval)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnLedRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnBuzzerRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                       ringTime:(NSInteger)ringTime
                                   ringInterval:(NSInteger)ringInterval
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (ringTime < 1 || ringTime > 6000 || ringInterval < 0 || ringInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1111),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"ring_time":@(ringTime),
            @"ring_interval":@(ringInterval)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnBuzzerRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                  notify:(BOOL)notify
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1115),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnNotifyAccDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnRemotePowerOffWithBleMac:(NSString *)bleMacAddress
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1118),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnRemotePowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnReadAdvParamsWithBleMac:(NSString *)bleMacAddress
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1120),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnReadAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnConfigAdvParamsWithParams:(NSDictionary *)params
                                    bleMac:(NSString *)bleMacAddress
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSMutableDictionary *advParam = [NSMutableDictionary dictionary];
    [advParam setObject:bleMacAddress forKey:@"mac"];
    [advParam setObject:params[@"channel"] forKey:@"channel"];
    if ([params[@"channelType"] integerValue] == 0) {
        NSDictionary * tempDic = @{
            @"adv_interval":params[@"advInterval"],
            @"tx_power":params[@"txPower"],
        };
        [advParam setObject:tempDic forKey:@"normal_adv"];
    }else if ([params[@"channelType"] integerValue] == 1) {
        NSDictionary * tempDic = @{
            @"adv_interval":params[@"advInterval"],
            @"tx_power":params[@"txPower"],
        };
        [advParam setObject:tempDic forKey:@"trigger_after_adv"];
    }else if ([params[@"channelType"] integerValue] == 2) {
        NSDictionary * tempDic1 = @{
            @"adv_interval":params[@"afterAdvInterval"],
            @"tx_power":params[@"afterTxPower"],
        };
        [advParam setObject:tempDic1 forKey:@"trigger_after_adv"];
        NSDictionary * tempDic2 = @{
            @"adv_interval":params[@"beforeAdvInterval"],
            @"tx_power":params[@"beforeTxPower"],
        };
        [advParam setObject:tempDic2 forKey:@"trigger_before_adv"];
    }
    NSDictionary *data = @{
        @"msg_id":@(1122),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":advParam
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnConfigAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  BXP-B-CR  ************************

+ (void)gw_connectBXPButtonCRWithPassword:(NSString *)password
                                   bleMac:(NSString *)bleMacAddress
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1150),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectBXPButtonCRWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPButtonCRConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                                    macAddress:(NSString *)macAddress
                                                         topic:(NSString *)topic
                                                      sucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1152),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPButtonCRConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPButtonCRConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                                macAddress:(NSString *)macAddress
                                                     topic:(NSString *)topic
                                                  sucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1154),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPButtonCRStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_dismissBXPButtonCRAlarmStatusWithBleMacAddress:(NSString *)bleMacAddress
                                               macAddress:(NSString *)macAddress
                                                    topic:(NSString *)topic
                                                 sucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1156),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskDismissBXPBCRAlarmStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRLedRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                  blinkingTime:(NSInteger)blinkingTime
                              blinkingInterval:(NSInteger)blinkingInterval
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (blinkingTime < 1 || blinkingTime > 6000 || blinkingInterval < 0 || blinkingInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1158),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"flash_time":@(blinkingTime),
            @"flash_interval":@(blinkingInterval)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRLedRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRBuzzerRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                         ringTime:(NSInteger)ringTime
                                     ringInterval:(NSInteger)ringInterval
                                       macAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (ringTime < 1 || ringTime > 6000 || ringInterval < 0 || ringInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1160),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"ring_time":@(ringTime),
            @"ring_interval":@(ringInterval)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRBuzzerRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_clearBXPButtonCREventCountWithType:(mk_gw_triggerEventType)type
                                bleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1162),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"type":@(type),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskClearBXPButtonCREventCountOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                    notify:(BOOL)notify
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1164),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRNotifyAccDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRRemotePowerOffWithBleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1167),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRRemotePowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRVibratingRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                       vibratingTime:(NSInteger)vibratingTime
                                   vibratingInterval:(NSInteger)vibratingInterval
                                          macAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (vibratingTime < 1 || vibratingTime > 6000 || vibratingInterval < 0 || vibratingInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1169),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"shake_time":@(vibratingTime),
            @"shake_interval":@(vibratingInterval)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRVibratingRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_BXPCRNotifyAlarmDataWithBleMac:(NSString *)bleMacAddress
                           alarmEventType:(mk_gw_bxpcrAlarmEventType)alarmEventType
                                   notify:(BOOL)notify
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1171),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"type":@(alarmEventType),
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPCRNotifyAlarmDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRReadAdvParamsWithBleMac:(NSString *)bleMacAddress
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1174),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRReadAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBtnCRConfigAdvParamsWithParams:(NSDictionary *)params
                                      bleMac:(NSString *)bleMacAddress
                                  macAddress:(NSString *)macAddress
                                       topic:(NSString *)topic
                                    sucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSMutableDictionary *advParam = [NSMutableDictionary dictionary];
    [advParam setObject:bleMacAddress forKey:@"mac"];
    [advParam setObject:params[@"channel"] forKey:@"channel"];
    if ([params[@"channelType"] integerValue] == 0) {
        NSDictionary * tempDic = @{
            @"adv_interval":params[@"advInterval"],
            @"tx_power":params[@"txPower"],
        };
        [advParam setObject:tempDic forKey:@"normal_adv"];
    }else if ([params[@"channelType"] integerValue] == 1) {
        NSDictionary * tempDic = @{
            @"adv_interval":params[@"advInterval"],
            @"tx_power":params[@"txPower"],
        };
        [advParam setObject:tempDic forKey:@"trigger_after_adv"];
    }else if ([params[@"channelType"] integerValue] == 2) {
        NSDictionary * tempDic1 = @{
            @"adv_interval":params[@"afterAdvInterval"],
            @"tx_power":params[@"afterTxPower"],
        };
        [advParam setObject:tempDic1 forKey:@"trigger_after_adv"];
        NSDictionary * tempDic2 = @{
            @"adv_interval":params[@"beforeAdvInterval"],
            @"tx_power":params[@"beforeTxPower"],
        };
        [advParam setObject:tempDic2 forKey:@"trigger_before_adv"];
    }
    NSDictionary *data = @{
        @"msg_id":@(1176),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":advParam
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpBtnCRConfigAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  BXP-C  ************************

+ (void)gw_connectBXPCWithPassword:(NSString *)password
                            bleMac:(NSString *)bleMacAddress
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1350),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectBXPCWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPCConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1352),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPCConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPCConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1354),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPCStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPCNotifyRealTimeHTDataWithBleMac:(NSString *)bleMacAddress
                                          notify:(BOOL)notify
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1356),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyBXPCNotifyRealTimeHTDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPCNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                   notify:(BOOL)notify
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1359),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPCNotifyAccDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPCNotifyHistoricalHTDataWithBleMac:(NSString *)bleMacAddress
                                            notify:(BOOL)notify
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1362),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyBXPCNotifyHistoricalHTDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPCDeleteHistoricalHTDataWithBleMac:(NSString *)bleMacAddress
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1365),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskDeleteBXPCHistoricalHTDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPCPowerOffWithBleMac:(NSString *)bleMacAddress
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1367),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpCPowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPCTHDataSampleRateWithBleMacAddress:(NSString *)bleMacAddress
                                          macAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1369),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPCTHDataSampleRateOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPCSampleRate:(NSInteger)sampleRate
                         bleMac:(NSString *)bleMacAddress
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (sampleRate < 1 || sampleRate > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1371),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"sampling_rate":@(sampleRate),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPCSampleRateOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPCAdvParamsWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1373),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPCAdvParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPCAdvParamsWithChannel:(NSInteger)channel
                                 interval:(NSInteger)interval
                                  txPower:(NSInteger)txPower
                                   bleMac:(NSString *)bleMacAddress
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (channel < 0 || channel > 5 || interval < 1 || interval > 100 || txPower < 0 || txPower > 8) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSInteger tempTx = -40;
    if (txPower == 1) {
        tempTx = -20;
    }else if (txPower == 2) {
        tempTx = -16;
    }else if (txPower == 3) {
        tempTx = -12;
    }else if (txPower == 4) {
        tempTx = -8;
    }else if (txPower == 5) {
        tempTx = -4;
    }else if (txPower == 6) {
        tempTx = 0;
    }else if (txPower == 7) {
        tempTx = 3;
    }else if (txPower == 8) {
        tempTx = 4;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1375),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"channel":@(channel),
            @"adv_interval":@(interval * 100),
            @"tx_power":@(tempTx)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPCAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  BXP-D  ************************

+ (void)gw_connectBXPDWithPassword:(NSString *)password
                            bleMac:(NSString *)bleMacAddress
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1400),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectBXPDWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPDConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1402),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPDConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPDConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1404),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPDStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPDAccParamsWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1406),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPDAccParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPDAccParamsWithScale:(mk_gw_threeAxisDataAG)scale
                             sampleRate:(mk_gw_threeAxisDataRate)sampleRate
                            sensitivity:(NSInteger)sensitivity
                                 bleMac:(NSString *)bleMacAddress
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (scale == mk_gw_threeAxisDataAG0 && (sensitivity < 1 || sensitivity > 20)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }else if (scale == mk_gw_threeAxisDataAG1 && (sensitivity < 1 || sensitivity > 40)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }else if (scale == mk_gw_threeAxisDataAG2 && (sensitivity < 1 || sensitivity > 80)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }else if (scale == mk_gw_threeAxisDataAG3 && (sensitivity < 1 || sensitivity > 160)) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1408),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"full_scale":@(scale),
            @"sensitivity":@(sensitivity),
            @"sampling_rate":@(sampleRate)
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPDAccParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPDNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                   notify:(BOOL)notify
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1414),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPDNotifyAccDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPDPowerOffWithBleMac:(NSString *)bleMacAddress
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1417),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpDPowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPDAdvParamsWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1419),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPDAdvParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPDAdvParamsWithChannel:(NSInteger)channel
                                 interval:(NSInteger)interval
                                  txPower:(NSInteger)txPower
                                   bleMac:(NSString *)bleMacAddress
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (channel < 0 || channel > 5 || interval < 1 || interval > 100 || txPower < 0 || txPower > 8) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSInteger tempTx = -40;
    if (txPower == 1) {
        tempTx = -20;
    }else if (txPower == 2) {
        tempTx = -16;
    }else if (txPower == 3) {
        tempTx = -12;
    }else if (txPower == 4) {
        tempTx = -8;
    }else if (txPower == 5) {
        tempTx = -4;
    }else if (txPower == 6) {
        tempTx = 0;
    }else if (txPower == 7) {
        tempTx = 3;
    }else if (txPower == 8) {
        tempTx = 4;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1421),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"channel":@(channel),
            @"adv_interval":@(interval * 100),
            @"tx_power":@(tempTx)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPDAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  BXP-T  ************************

+ (void)gw_connectBXPTWithPassword:(NSString *)password
                            bleMac:(NSString *)bleMacAddress
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1450),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectBXPTWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPTConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1452),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPTConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPTConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1454),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPTStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPTAccParamsWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1456),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPTAccParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPTAccParamsWithScale:(mk_gw_threeAxisDataAG)scale
                             sampleRate:(mk_gw_threeAxisDataRate)sampleRate
                            sensitivity:(NSInteger)sensitivity
                                 bleMac:(NSString *)bleMacAddress
                             macAddress:(NSString *)macAddress
                                  topic:(NSString *)topic
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (sensitivity < 1 || sensitivity > 255) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1458),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"full_scale":@(scale),
            @"sensitivity":@(sensitivity),
            @"sampling_rate":@(sampleRate)
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPTAccParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPTMotioEventCountWithBleMacAddress:(NSString *)bleMacAddress
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1460),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPTMotioEventCountOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_clearBXPTMotioEventCountWithBleMacAddress:(NSString *)bleMacAddress
                                          macAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1462),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskClearBXPTMotioEventCountOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPTLedRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                        color:(mk_gw_bxptLedColor)color
                                 blinkingTime:(NSInteger)blinkingTime
                             blinkingInterval:(NSInteger)blinkingInterval
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (blinkingTime < 1 || blinkingTime > 600 || blinkingInterval < 1 || blinkingInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *colorString = @"green";
    if (color == mk_gw_bxptLedColor_blue) {
        colorString = @"blue";
    }else if (color == mk_gw_bxptLedColor_red) {
        colorString = @"red";
    }
    NSDictionary *data = @{
        @"msg_id":@(1464),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"color":colorString,
            @"flash_time":@(blinkingTime),
            @"flash_interval":@(blinkingInterval * 100)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPTLedRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPTNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                   notify:(BOOL)notify
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1466),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPTNotifyAccDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPTPowerOffWithBleMac:(NSString *)bleMacAddress
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1469),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBxpTPowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPTAdvParamsWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1471),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPTAdvParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPTAdvParamsWithChannel:(NSInteger)channel
                                 interval:(NSInteger)interval
                                  txPower:(NSInteger)txPower
                                   bleMac:(NSString *)bleMacAddress
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (channel < 0 || channel > 5 || interval < 1 || interval > 100 || txPower < 0 || txPower > 8) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSInteger tempTx = -20;
    if (txPower == 1) {
        tempTx = -16;
    }else if (txPower == 2) {
        tempTx = -12;
    }else if (txPower == 3) {
        tempTx = -8;
    }else if (txPower == 4) {
        tempTx = -4;
    }else if (txPower == 5) {
        tempTx = 0;
    }else if (txPower == 6) {
        tempTx = 3;
    }else if (txPower == 7) {
        tempTx = 4;
    }else if (txPower == 8) {
        tempTx = 6;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1473),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"channel":@(channel),
            @"adv_interval":@(interval),
            @"tx_power":@(tempTx)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPTAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  BXP-S  ************************

+ (void)gw_connectBXPSWithPassword:(NSString *)password
                            bleMac:(NSString *)bleMacAddress
                        macAddress:(NSString *)macAddress
                             topic:(NSString *)topic
                          sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1500),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectBXPSWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPSConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                             macAddress:(NSString *)macAddress
                                                  topic:(NSString *)topic
                                               sucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1502),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPSConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPSConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                         macAddress:(NSString *)macAddress
                                              topic:(NSString *)topic
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1504),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPSStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPSNotifyRealTimeHTDataWithBleMac:(NSString *)bleMacAddress
                                          notify:(BOOL)notify
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1506),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyBXPSNotifyRealTimeHTDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPSNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                   notify:(BOOL)notify
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1509),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0)),
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPSNotifyAccDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPSNotifyHistoricalHTDataWithBleMac:(NSString *)bleMacAddress
                                            notify:(BOOL)notify
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1512),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyBXPSNotifyHistoricalHTDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPSDeleteHistoricalHTDataWithBleMac:(NSString *)bleMacAddress
                                        macAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1515),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskDeleteBXPSHistoricalHTDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPSTHDataSampleRateWithBleMacAddress:(NSString *)bleMacAddress
                                          macAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1517),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPSTHDataSampleRateOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPSSampleRate:(NSInteger)sampleRate
                         bleMac:(NSString *)bleMacAddress
                     macAddress:(NSString *)macAddress
                          topic:(NSString *)topic
                       sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (sampleRate < 1 || sampleRate > 65535) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1519),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"sampling_rate":@(sampleRate),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPSSampleRateOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPSHallCountWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1521),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPSHallCountOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_clearBXPSHallCountWithBleMacAddress:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1523),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskClearBXPSHallCountOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPSLedRemoteReminderWithBleMac:(NSString *)bleMacAddress
                                        color:(mk_gw_bxptLedColor)color
                                 blinkingTime:(NSInteger)blinkingTime
                             blinkingInterval:(NSInteger)blinkingInterval
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (blinkingTime < 1 || blinkingTime > 600 || blinkingInterval < 1 || blinkingInterval > 100) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSString *colorString = @"green";
    if (color == mk_gw_bxptLedColor_blue) {
        colorString = @"blue";
    }else if (color == mk_gw_bxptLedColor_red) {
        colorString = @"red";
    }
    NSDictionary *data = @{
        @"msg_id":@(1525),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"color":colorString,
            @"flash_time":@(blinkingTime * 10),
            @"flash_interval":@(blinkingInterval * 100)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPSLedRemoteReminderOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpBXPSPowerOffWithBleMac:(NSString *)bleMacAddress
                          macAddress:(NSString *)macAddress
                               topic:(NSString *)topic
                            sucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1527),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskBXPSPowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readBXPSAdvParamsWithBleMacAddress:(NSString *)bleMacAddress
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1529),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBXPSAdvParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBXPSAdvParamsWithParams:(NSDictionary *)params
                                  bleMac:(NSString *)bleMacAddress
                              macAddress:(NSString *)macAddress
                                   topic:(NSString *)topic
                                sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSMutableDictionary *advParam = [NSMutableDictionary dictionary];
    [advParam setObject:bleMacAddress forKey:@"mac"];
    [advParam setObject:params[@"channel"] forKey:@"channel"];
    if ([params[@"channelType"] integerValue] == 0) {
        NSDictionary * tempDic = @{
            @"adv_interval":params[@"advInterval"],
            @"tx_power":params[@"txPower"],
        };
        [advParam setObject:tempDic forKey:@"normal_adv"];
    }else if ([params[@"channelType"] integerValue] == 1) {
        NSDictionary * tempDic = @{
            @"adv_interval":params[@"advInterval"],
            @"tx_power":params[@"txPower"],
        };
        [advParam setObject:tempDic forKey:@"trigger_after_adv"];
    }else if ([params[@"channelType"] integerValue] == 2) {
        NSDictionary * tempDic1 = @{
            @"adv_interval":params[@"afterAdvInterval"],
            @"tx_power":params[@"afterTxPower"],
        };
        [advParam setObject:tempDic1 forKey:@"trigger_after_adv"];
        NSDictionary * tempDic2 = @{
            @"adv_interval":params[@"beforeAdvInterval"],
            @"tx_power":params[@"beforeTxPower"],
        };
        [advParam setObject:tempDic2 forKey:@"trigger_before_adv"];
    }
    NSDictionary *data = @{
        @"msg_id":@(1531),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":advParam
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBXPSAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  MK Pir  ************************

+ (void)gw_connectMKPirWithPassword:(NSString *)password
                             bleMac:(NSString *)bleMacAddress
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1550),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectMKPirWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKPirConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                              macAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1552),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKPirConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKPirConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                          macAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1554),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKPirStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_notifyMKPirSensorDataWithBleMac:(NSString *)bleMacAddress
                                    notify:(BOOL)notify
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1556),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyMKPirSensorDataOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKPirSensorSensitivityWithBleMac:(NSString *)bleMacAddress
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1559),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKPirSensorSensitivityOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configMKPirSensorSensitivityWithBleMac:(NSString *)bleMacAddress
                                      sensitivity:(mk_gw_pirSensorParamType)sensitivity
                                     macAddress:(NSString *)macAddress
                                          topic:(NSString *)topic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1561),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"sensitivity":@(sensitivity)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigMKPirSensorSensitivityOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKPirSensorDelayWithBleMac:(NSString *)bleMacAddress
                               macAddress:(NSString *)macAddress
                                    topic:(NSString *)topic
                                 sucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1563),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKPirSensorDelayOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configMKPirSensorDelayWithBleMac:(NSString *)bleMacAddress
                                      delay:(mk_gw_pirSensorParamType)delay
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1565),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"delay_status":@(delay)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigMKPirSensorDelayOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpMKPirPowerOffWithBleMac:(NSString *)bleMacAddress
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1567),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskMKPirPowerOffOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKPirAdvParamsWithBleMacAddress:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1569),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKPirAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configMKPirAdvParamsWithInterval:(NSInteger)interval
                                    txPower:(NSInteger)txPower
                                     bleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 1 || interval > 100 || txPower < 0 || txPower > 7) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSInteger tempTx = 7;
    if (txPower == 1) {
        //-20dBm
        tempTx = 6;
    }else if (txPower == 2) {
        //-16dBm
        tempTx = 5;
    }else if (txPower == 3) {
        //-12dBm
        tempTx = 4;
    }else if (txPower == 4) {
        //-8dBm
        tempTx = 3;
    }else if (txPower == 5) {
        //-4dBm
        tempTx = 2;
    }else if (txPower == 6) {
        //0dBm
        tempTx = 1;
    }else if (txPower == 7) {
        //4dBm
        tempTx = 0;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1571),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"adv_interval":@(interval),
            @"tx_power":@(tempTx)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigMKPirAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  MK Tof  ************************

+ (void)gw_connectMKTofWithPassword:(NSString *)password
                             bleMac:(NSString *)bleMacAddress
                         macAddress:(NSString *)macAddress
                              topic:(NSString *)topic
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (password.length > 16) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1600),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"passwd":SafeStr(password),
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConnectMKTofWithMacOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKTofConnectedDeviceInfoWithBleMacAddress:(NSString *)bleMacAddress
                                              macAddress:(NSString *)macAddress
                                                   topic:(NSString *)topic
                                                sucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1602),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKTofConnectedDeviceInfoOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKTofConnectedStatusWithBleMacAddress:(NSString *)bleMacAddress
                                          macAddress:(NSString *)macAddress
                                               topic:(NSString *)topic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1604),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKTofStatusOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpMKTofNotifyAccDataWithBleMac:(NSString *)bleMacAddress
                                    notify:(BOOL)notify
                                macAddress:(NSString *)macAddress
                                     topic:(NSString *)topic
                                  sucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1606),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyMKTofAccDataOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpMKTofPowerOffWithBleMac:(NSString *)bleMacAddress
                           macAddress:(NSString *)macAddress
                                topic:(NSString *)topic
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1609),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskMKTofPowerOffOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKTofAdvParamsWithBleMacAddress:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1611),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKTofAdvParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configMKTofAdvParamsWithInterval:(NSInteger)interval
                                    txPower:(NSInteger)txPower
                                     bleMac:(NSString *)bleMacAddress
                                 macAddress:(NSString *)macAddress
                                      topic:(NSString *)topic
                                   sucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (interval < 1 || interval > 86400 || txPower < 0 || txPower > 8) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    NSInteger tempTx = 7;
    if (txPower == 1) {
        //-20dBm
        tempTx = 6;
    }else if (txPower == 2) {
        //-16dBm
        tempTx = 5;
    }else if (txPower == 3) {
        //-12dBm
        tempTx = 4;
    }else if (txPower == 4) {
        //-8dBm
        tempTx = 3;
    }else if (txPower == 5) {
        //-4dBm
        tempTx = 2;
    }else if (txPower == 6) {
        //0dBm
        tempTx = 1;
    }else if (txPower == 7) {
        //4dBm
        tempTx = 0;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1613),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"adv_interval":@(interval),
            @"tx_power":@(tempTx)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigMKTofAdvParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKTofSensorParamsWithBleMacAddress:(NSString *)bleMacAddress
                                       macAddress:(NSString *)macAddress
                                            topic:(NSString *)topic
                                         sucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1615),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKTofSensorParamsOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configMKTofSensorParamsWithInterval:(NSInteger)sampleInterval
                                   sampleCount:(NSInteger)sampleCount
                                    sampleTime:(NSInteger)sampleTime
                                        bleMac:(NSString *)bleMacAddress
                                    macAddress:(NSString *)macAddress
                                         topic:(NSString *)topic
                                      sucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (sampleInterval < 1 || sampleInterval > 86400 || sampleCount < 2 || sampleCount > 255 || sampleTime < 8 || sampleTime > 140 || ((sampleCount + 1) * sampleTime * 0.001) > sampleInterval) {
        [self operationFailedBlockWithMsg:@"Params Error" failedBlock:failedBlock];
        return;
    }
    
    NSDictionary *data = @{
        @"msg_id":@(1617),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"interval":@(sampleInterval),
            @"count":@(sampleCount),
            @"time":@(sampleTime)
        }
    };
    
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigMKTofSensorParamsOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_readMKTofRangingModeWithBleMacAddress:(NSString *)bleMacAddress
                                      macAddress:(NSString *)macAddress
                                           topic:(NSString *)topic
                                        sucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1619),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadMKTofRangingModeOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configMKTofRangingMode:(mk_gw_tofRangingMode)mode
                           bleMac:(NSString *)bleMacAddress
                       macAddress:(NSString *)macAddress
                            topic:(NSString *)topic
                         sucBlock:(void (^)(id returnData))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1621),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"mode":@(mode + 1)
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigMKTofRangingModeOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_bxpMKTofNotifySensorDataWithBleMac:(NSString *)bleMacAddress
                                       notify:(BOOL)notify
                                   macAddress:(NSString *)macAddress
                                        topic:(NSString *)topic
                                     sucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (!ValidStr(bleMacAddress) || bleMacAddress.length != 12 || ![bleMacAddress regularExpressions:isHexadecimal]) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1623),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
            @"mac":bleMacAddress,
            @"switch_value":(notify ? @(1) : @(0))
        }
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskNotifyMKTofSensorDataOperation
                                   timeout:50
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark *********************  Normal Ble  ************************
+ (void)gw_readBleCommunicateTimeoutWithMacAddress:(NSString *)macAddress
                                             topic:(NSString *)topic
                                          sucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(2209),
        @"device_info":@{
                @"mac":macAddress
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskReadBleCommunicateTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

+ (void)gw_configBleCommunicateTimeout:(NSInteger)timeout
                            macAddress:(NSString *)macAddress
                                 topic:(NSString *)topic
                              sucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *checkMsg = [self checkMacAddress:macAddress topic:topic];
    if (ValidStr(checkMsg)) {
        [self operationFailedBlockWithMsg:checkMsg failedBlock:failedBlock];
        return;
    }
    if (timeout < 0 || timeout > 60) {
        [self operationFailedBlockWithMsg:@"Params error" failedBlock:failedBlock];
        return;
    }
    NSDictionary *data = @{
        @"msg_id":@(1209),
        @"device_info":@{
                @"mac":macAddress
        },
        @"data":@{
                @"timeout":@(timeout),
        },
    };
    [[MKGWMQTTDataManager shared] sendData:data
                                     topic:topic
                                macAddress:macAddress
                                    taskID:mk_gw_server_taskConfigBleCommunicateTimeoutOperation
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
}

#pragma mark - private method
+ (NSString *)checkMacAddress:(NSString *)macAddress
                      topic:(NSString *)topic {
    if (!ValidStr(topic) || topic.length > 128 || ![topic isAsciiString]) {
        return @"Topic error";
    }
    if (!ValidStr(macAddress)) {
        return @"Mac error";
    }
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@" " withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@":" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"-" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"_" withString:@""];
    if (macAddress.length != 12 || ![macAddress regularExpressions:isHexadecimal]) {
        return @"Mac error";
    }
    return @"";
}

+ (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.RGMQTTManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

+ (BOOL)isConfirmRawFilterProtocol:(id <mk_gw_BLEFilterRawDataProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_BLEFilterRawDataProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.dataType) || protocol.dataType.length != 2 || ![protocol.dataType regularExpressions:isHexadecimal]) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex == 0) {
        if (!ValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![protocol.rawData regularExpressions:isHexadecimal] || (protocol.rawData.length % 2 != 0)) {
            return NO;
        }
        return YES;
    }
    if (protocol.maxIndex == 0 && protocol.minIndex != 0) {
        return NO;
    }
    if (protocol.minIndex == 0 && protocol.maxIndex != 0) {
        return NO;
    }
    if (protocol.minIndex < 0 || protocol.minIndex > 29 || protocol.maxIndex < 0 || protocol.maxIndex > 29) {
        return NO;
    }
    
    if (protocol.maxIndex < protocol.minIndex) {
        return NO;
    }
    if (!ValidStr(protocol.rawData) || protocol.rawData.length > 58 || ![protocol.rawData regularExpressions:isHexadecimal]) {
        return NO;
    }
    NSInteger totalLen = (protocol.maxIndex - protocol.minIndex + 1) * 2;
    if (protocol.rawData.length != totalLen) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmPirPresenceProtocol:(id <mk_gw_BLEFilterPirProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_BLEFilterPirProtocol)]) {
        return NO;
    }
    if (protocol.delayRespneseStatus < 0 || protocol.delayRespneseStatus > 3) {
        return NO;
    }
    if (protocol.doorStatus < 0 || protocol.doorStatus > 2) {
        return NO;
    }
    if (protocol.sensorSensitivity < 0 || protocol.sensorSensitivity > 3) {
        return NO;
    }
    if (protocol.sensorDetectionStatus < 0 || protocol.sensorDetectionStatus > 2) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmWifiProtocol:(id <mk_gw_mqttModifyWifiProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_mqttModifyWifiProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.ssid) || protocol.ssid.length > 32) {
        return NO;
    }
    if (protocol.security == 0) {
        //Personal
        if (protocol.wifiPassword.length > 64) {
            return NO;
        }
        return YES;
    }
    //Enterprise
    if (protocol.eapType == 0 || protocol.eapType == 1) {
        //PEAP-MSCHAPV2/TTLS-MSCHAPV2
        if (protocol.eapUserName.length > 32) {
            return NO;
        }
        if (protocol.eapPassword.length > 64) {
            return NO;
        }
    }
    if (protocol.eapType == 2) {
        //TLS
        if (protocol.domainID.length > 64) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isConfirmEAPCertProtocol:(id <mk_gw_mqttModifyWifiEapCertProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_mqttModifyWifiEapCertProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.caFilePath) && !ValidStr(protocol.clientKeyPath) && !ValidStr(protocol.clientCertPath)) {
        return NO;
    }
    if (protocol.clientKeyPath.length > 256 || protocol.clientCertPath.length > 256 || protocol.caFilePath.length > 256) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmNetworkProtocol:(id <mk_gw_mqttModifyNetworkProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_mqttModifyNetworkProtocol)]) {
        return NO;
    }
    if (protocol.dhcp) {
        return YES;
    }
    if (![protocol.ip regularExpressions:isIPAddress]) {
        return NO;
    }
    if (![protocol.mask regularExpressions:isIPAddress]) {
        return NO;
    }
    if (![protocol.gateway regularExpressions:isIPAddress]) {
        return NO;
    }
    if (![protocol.dns regularExpressions:isIPAddress]) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmMqttServerProtocol:(id <mk_gw_modifyMqttServerProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_modifyMqttServerProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.host) || protocol.host.length > 64 || ![protocol.host isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.port) || [protocol.port integerValue] < 1 || [protocol.port integerValue] > 65535) {
        return NO;
    }
    if (!ValidStr(protocol.clientID) || protocol.clientID.length > 64 || ![protocol.clientID isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.publishTopic) || protocol.publishTopic.length > 128 || ![protocol.publishTopic isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.subscribeTopic) || protocol.subscribeTopic.length > 128 || ![protocol.subscribeTopic isAsciiString]) {
        return NO;
    }
    if (protocol.qos < 0 || protocol.qos > 2) {
        return NO;
    }
    if (!ValidStr(protocol.keepAlive) || [protocol.keepAlive integerValue] < 10 || [protocol.keepAlive integerValue] > 120) {
        return NO;
    }
    if (protocol.userName.length > 256 || (ValidStr(protocol.userName) && ![protocol.userName isAsciiString])) {
        return NO;
    }
    if (protocol.password.length > 256 || (ValidStr(protocol.password) && ![protocol.password isAsciiString])) {
        return NO;
    }
    if (protocol.connectMode < 0 || protocol.connectMode > 3) {
        return NO;
    }
    if (protocol.lwtQos < 0 || protocol.lwtQos > 2) {
        return NO;
    }
    if (!ValidStr(protocol.lwtTopic) || protocol.lwtTopic.length > 128 || ![protocol.lwtTopic isAsciiString]) {
        return NO;
    }
    if (!ValidStr(protocol.lwtPayload) || protocol.lwtPayload.length > 128 || ![protocol.lwtPayload isAsciiString]) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmMqttServerCertsProtocol:(id <mk_gw_modifyMqttServerCertsProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(mk_gw_modifyMqttServerCertsProtocol)]) {
        return NO;
    }
    if (!ValidStr(protocol.caFilePath) && !ValidStr(protocol.clientKeyPath) && !ValidStr(protocol.clientCertPath)) {
        return NO;
    }
    if (protocol.clientKeyPath.length > 256 || protocol.clientCertPath.length > 256 || protocol.caFilePath.length > 256) {
        return NO;
    }
    return YES;
}

+ (BOOL)isConfirmAdvBeaconProtocol:(id <gw_advertiseBeaconProtocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(gw_advertiseBeaconProtocol)]) {
        return NO;
    }
    if (protocol.advertise) {
        if (protocol.major < 0 || protocol.major > 65535 || protocol.minor < 0 || protocol.minor > 65535) {
            return NO;
        }
        if (!ValidStr(protocol.uuid) || protocol.uuid.length != 32 || ![protocol.uuid regularExpressions:isHexadecimal]) {
            return NO;
        }
        if (protocol.advInterval < 1 || protocol.advInterval > 100 || protocol.txPower < 0 || protocol.txPower > 15) {
            return NO;
        }
    }
    return YES;
}

+ (BOOL)isConfirmAdvBeaconV2Protocol:(id <gw_advertiseBeaconV2Protocol>)protocol {
    if (![protocol conformsToProtocol:@protocol(gw_advertiseBeaconV2Protocol)]) {
        return NO;
    }
    if (protocol.advertise) {
        if (protocol.major < 0 || protocol.major > 65535 || protocol.minor < 0 || protocol.minor > 65535) {
            return NO;
        }
        if (!ValidStr(protocol.uuid) || protocol.uuid.length != 32 || ![protocol.uuid regularExpressions:isHexadecimal]) {
            return NO;
        }
        if (protocol.advInterval < 1 || protocol.advInterval > 100 || protocol.txPower < 0 || protocol.txPower > 15) {
            return NO;
        }
        if (protocol.rssi1M < -100 || protocol.rssi1M > 0) {
            return NO;
        }
    }
    return YES;
}


@end
