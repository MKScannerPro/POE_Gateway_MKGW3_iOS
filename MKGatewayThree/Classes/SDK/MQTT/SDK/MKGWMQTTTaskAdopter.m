//
//  MKGWMQTTTaskAdopter.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWMQTTTaskAdopter.h"

#import "MKMacroDefines.h"

#import "MKGWMQTTTaskID.h"

@implementation MKGWMQTTTaskAdopter

+ (NSDictionary *)parseDataWithJson:(NSDictionary *)json topic:(NSString *)topic {
    NSInteger msgID = [json[@"msg_id"] integerValue];
    if (msgID >= 1000 && msgID < 2000) {
        //配置指令
        return [self parseConfigParamsWithJson:json msgID:msgID topic:topic];
    }
    if (msgID >= 2000 && msgID < 3000) {
        //读取指令
        return [self parseReadParamsWithJson:json msgID:msgID topic:topic];
    }
    if (msgID == 3101) {
        //连接指定mac地址的BXP-Button设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectBXPButtonWithMacOperation];
    }
    if (msgID == 3103) {
        //读取已连接BXP-Button设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPButtonConnectedDeviceInfoOperation];
    }
    if (msgID == 3105) {
        //读取已连接BXP-Button的状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPButtonStatusOperation];
    }
    if (msgID == 3107) {
        //BXP-Button消警
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskDismissAlarmStatusOperation];
    }
    if (msgID == 3110) {
        //BXP-B-D led远程消警
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnLedRemoteReminderOperation];
    }
    if (msgID == 3112) {
        //BXP-B-D led远程消警
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnBuzzerRemoteReminderOperation];
    }
    if (msgID == 3114) {
        //删除触发记录
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskClearTriggerEventCountOperation];
    }
    if (msgID == 3116) {
        //BXP-B-D 监听三轴数据
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnNotifyAccDataOperation];
    }
    if (msgID == 3119) {
        //BXP-B-D 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnRemotePowerOffOperation];
    }
    if (msgID == 3121) {
        //BXP-B-D 广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnReadAdvParamsOperation];
    }
    if (msgID == 3123) {
        //BXP-B-D 广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnConfigAdvParamsOperation];
    }
    if (msgID == 3151) {
        //BXP-B-CR 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectBXPButtonCRWithMacOperation];
    }
    if (msgID == 3153) {
        //BXP-B-CR 设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPButtonCRConnectedDeviceInfoOperation];
    }
    if (msgID == 3155) {
        //BXP-B-CR获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPButtonCRStatusOperation];
    }
    if (msgID == 3157) {
        //BXP-B-CR消警
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskDismissBXPBCRAlarmStatusOperation];
    }
    if (msgID == 3159) {
        //BXP-B-CR控制LED
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRLedRemoteReminderOperation];
    }
    if (msgID == 3161) {
        //BXP-B-CR控制蜂鸣器
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRBuzzerRemoteReminderOperation];
    }
    if (msgID == 3165) {
        //BXP-B-CR监听三轴数据开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRNotifyAccDataOperation];
    }
    if (msgID == 3168) {
        //BXP-B-CR 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRRemotePowerOffOperation];
    }
    if (msgID == 3170) {
        //BXP-B-CR控制马达
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRVibratingRemoteReminderOperation];
    }
    if (msgID == 3175) {
        //BXP-B-CR读取广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRReadAdvParamsOperation];
    }
    if (msgID == 3177) {
        //BXP-B-CR配置广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpBtnCRConfigAdvParamsOperation];
    }
    if (msgID == 3301) {
        //网关连接指定mac地址的蓝牙设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectNormalBleDeviceWithMacOperation];
    }
    if (msgID == 3304) {
        //读取蓝牙网关连接的指定设备的服务和特征信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadNormalConnectedDeviceInfoOperation];
    }
    if (msgID == 3306) {
        //打开/关闭监听指定特征
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyCharacteristicOperation];
    }
    if (msgID == 3308) {
        //读取蓝牙网关连接的指定设备的服务和特征信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadCharacteristicValueOperation];
    }
    if (msgID == 3310) {
        //向蓝牙网关连接的指定设备的指定特征写入值
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskWriteCharacteristicValueOperation];
    }
    if (msgID == 3351) {
        //BXP-C 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectBXPCWithMacOperation];
    }
    if (msgID == 3353) {
        //BXP-C 读取设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPCConnectedDeviceInfoOperation];
    }
    if (msgID == 3355) {
        //BXP-C 获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPCStatusOperation];
    }
    if (msgID == 3357) {
        //控制实时温湿度数据监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyBXPCNotifyRealTimeHTDataOperation];
    }
    if (msgID == 3360) {
        //BXP-C 实时三轴数据监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPCNotifyAccDataOperation];
    }
    if (msgID == 3363) {
        //控制历史温湿度数据监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyBXPCNotifyHistoricalHTDataOperation];
    }
    if (msgID == 3366) {
        //清除历史温湿度数据
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskDeleteBXPCHistoricalHTDataOperation];
    }
    if (msgID == 3368) {
        //BXP-C 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpCPowerOffOperation];
    }
    if (msgID == 3370) {
        //BXP-C 读取温湿度采样率
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPCTHDataSampleRateOperation];
    }
    if (msgID == 3372) {
        //BXP-C 配置温湿度采样率
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPCSampleRateOperation];
    }
    if (msgID == 3374) {
        //BXP-C 读取广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPCAdvParamsOperation];
    }
    if (msgID == 3376) {
        //BXP-C 配置广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPCAdvParamsOperation];
    }
    if (msgID == 3401) {
        //BXP-D 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectBXPDWithMacOperation];
    }
    if (msgID == 3403) {
        //BXP-D 读取设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPDConnectedDeviceInfoOperation];
    }
    if (msgID == 3405) {
        //BXP-D 获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPDStatusOperation];
    }
    if (msgID == 3407) {
        //BXP-D 读取三轴参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPDAccParamsOperation];
    }
    if (msgID == 3409) {
        //BXP-D 配置三轴参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPDAccParamsOperation];
    }
    if (msgID == 3415) {
        //BXP-D 实时三轴监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPDNotifyAccDataOperation];
    }
    if (msgID == 3418) {
        //BXP-D 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpDPowerOffOperation];
    }
    if (msgID == 3420) {
        //BXP-D 读取广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPDAdvParamsOperation];
    }
    if (msgID == 3422) {
        //BXP-D 配置广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPDAdvParamsOperation];
    }
    if (msgID == 3451) {
        //BXP-T 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectBXPTWithMacOperation];
    }
    if (msgID == 3453) {
        //BXP-T 读取设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPTConnectedDeviceInfoOperation];
    }
    if (msgID == 3455) {
        //BXP-T 获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPTStatusOperation];
    }
    if (msgID == 3457) {
        //BXP-T 读取三轴参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPTAccParamsOperation];
    }
    if (msgID == 3459) {
        //BXP-T 配置三轴参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPTAccParamsOperation];
    }
    if (msgID == 3461) {
        //BXP-T 读取移动触发次数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPTMotioEventCountOperation];
    }
    if (msgID == 3463) {
        //BXP-T 清除移动触发次数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskClearBXPTMotioEventCountOperation];
    }
    if (msgID == 3465) {
        //BXP-T 远程控制LED
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPTLedRemoteReminderOperation];
    }
    if (msgID == 3467) {
        //BXP-T 实时三轴监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPTNotifyAccDataOperation];
    }
    if (msgID == 3470) {
        //BXP-T 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpTPowerOffOperation];
    }
    if (msgID == 3472) {
        //BXP-T 读取广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPTAdvParamsOperation];
    }
    if (msgID == 3474) {
        //BXP-T 配置广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPTAdvParamsOperation];
    }
    if (msgID == 3501) {
        //BXP-S 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectBXPSWithMacOperation];
    }
    if (msgID == 3503) {
        //BXP-S 读取设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPSConnectedDeviceInfoOperation];
    }
    if (msgID == 3505) {
        //BXP-S 获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPSStatusOperation];
    }
    if (msgID == 3507) {
        //BXP-S 控制实时温湿度数据监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyBXPSNotifyRealTimeHTDataOperation];
    }
    if (msgID == 3510) {
        //BXP-S 实时三轴数据监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPSNotifyAccDataOperation];
    }
    if (msgID == 3513) {
        //BXP-S 控制历史温湿度数据监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyBXPSNotifyHistoricalHTDataOperation];
    }
    if (msgID == 3516) {
        //BXP-S 清除历史温湿度数据
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskDeleteBXPSHistoricalHTDataOperation];
    }
    if (msgID == 3518) {
        //BXP-S 读取温湿度采样率
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPSTHDataSampleRateOperation];
    }
    if (msgID == 3520) {
        //BXP-S 配置温湿度采样率
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigBXPSSampleRateOperation];
    }
    if (msgID == 3522) {
        //BXP-S 读取hall触发次数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadBXPSHallCountOperation];
    }
    if (msgID == 3524) {
        //BXP-S 清除hall触发次数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskClearBXPSHallCountOperation];
    }
    if (msgID == 3526) {
        //BXP-S 远程控制LED
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPSLedRemoteReminderOperation];
    }
    if (msgID == 3526) {
        //BXP-S 实时三轴监听开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBXPSNotifyAccDataOperation];
    }
    if (msgID == 3528) {
        //BXP-T 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskBxpSPowerOffOperation];
    }
    if (msgID == 3551) {
        //MK Pir 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectMKPirWithMacOperation];
    }
    if (msgID == 3553) {
        //MK Pir 读取设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKPirConnectedDeviceInfoOperation];
    }
    if (msgID == 3555) {
        //MK Pir 获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKPirStatusOperation];
    }
    if (msgID == 3557) {
        //MK Pir 监听传感器数据
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyMKPirSensorDataOperation];
    }
    if (msgID == 3560) {
        //MK Pir 读取灵敏度
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKPirSensorSensitivityOperation];
    }
    if (msgID == 3562) {
        //MK Pir 配置灵敏度
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigMKPirSensorSensitivityOperation];
    }
    if (msgID == 3564) {
        //MK Pir 读取延时状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKPirSensorDelayOperation];
    }
    if (msgID == 3566) {
        //MK Pir 配置延时状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigMKPirSensorDelayOperation];
    }
    if (msgID == 3568) {
        //MK Pir 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskMKPirPowerOffOperation];
    }
    if (msgID == 3570) {
        //MK Pir 读取广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKPirAdvParamsOperation];
    }
    if (msgID == 3572) {
        //MK Pir 配置广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigMKPirAdvParamsOperation];
    }
    if (msgID == 3601) {
        //MK Tof 连接设备
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConnectMKTofWithMacOperation];
    }
    if (msgID == 3603) {
        //MK Tof 读取设备信息
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKTofConnectedDeviceInfoOperation];
    }
    if (msgID == 3605) {
        //MK Tof 获取当前状态
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKTofStatusOperation];
    }
    if (msgID == 3607) {
        //MK Tof 监听三轴数据
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyMKTofAccDataOperation];
    }
    if (msgID == 3610) {
        //MK Tof 远程关机
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskMKTofPowerOffOperation];
    }
    if (msgID == 3612) {
        //MK Tof 读取广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKTofAdvParamsOperation];
    }
    if (msgID == 3614) {
        //MK Tof 配置广播参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigMKTofAdvParamsOperation];
    }
    if (msgID == 3616) {
        //MK Tof 读取采样参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKTofSensorParamsOperation];
    }
    if (msgID == 3618) {
        //MK Tof 配置采样参数
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigMKTofSensorParamsOperation];
    }
    if (msgID == 3620) {
        //MK Tof 读取距离模式
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskReadMKTofRangingModeOperation];
    }
    if (msgID == 3622) {
        //MK Tof 配置距离模式
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskConfigMKTofRangingModeOperation];
    }
    if (msgID == 3624) {
        //MK Tof 监听数据开关
        BOOL success = ([json[@"result_code"] integerValue] == 0);
        if (!success) {
            return @{};
        }
        return [self dataParserGetDataSuccess:json operationID:mk_gw_server_taskNotifyMKTofSensorDataOperation];
    }
    
    return @{};
}

#pragma mark - private method
+ (NSDictionary *)parseConfigParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    BOOL success = ([json[@"result_code"] integerValue] == 0);
    if (!success) {
        return @{};
    }
    mk_gw_serverOperationID operationID = mk_gw_defaultServerOperationID;
    if (msgID == 1000) {
        //重启设备
        operationID = mk_gw_server_taskRebootDeviceOperation;
    }else if (msgID == 1001) {
        //配置按键恢复出厂设置类型
        operationID = mk_gw_server_taskKeyResetTypeOperation;
    }else if (msgID == 1003) {
        //配置网络状态上报间隔
        operationID = mk_gw_server_taskConfigNetworkStatusReportIntervalOperation;
    }else if (msgID == 1005) {
        //配置网络重连超时时间
        operationID = mk_gw_server_taskConfigReconnectTimeoutOperation;
    }else if (msgID == 1006) {
        //OTA
        operationID = mk_gw_server_taskConfigOTAHostOperation;
    }else if (msgID == 1008) {
        //配置NTP服务器信息
        operationID = mk_gw_server_taskConfigNTPServerOperation;
    }else if (msgID == 1009) {
        //配置设备UTC时间
        operationID = mk_gw_server_taskConfigDeviceTimeZoneOperation;
    }else if (msgID == 1010) {
        //配置通信超时时间
        operationID = mk_gw_server_taskConfigCommunicationTimeoutOperation;
    }else if (msgID == 1011) {
        //配置指示灯开关
        operationID = mk_gw_server_taskConfigIndicatorLightStatusOperation;
    }else if (msgID == 1013) {
        //恢复出厂设置
        operationID = mk_gw_server_taskResetDeviceOperation;
    }else if (msgID == 1015) {
        //Npc OTA
        operationID = mk_gw_server_taskConfigNpcOTAHostOperation;
    }else if (msgID == 1020) {
        //配置wifi
        operationID = mk_gw_server_taskModifyWifiInfosOperation;
    }else if (msgID == 1021) {
        //配置wifi的EAP证书
        operationID = mk_gw_server_taskModifyWifiCertsOperation;
    }else if (msgID == 1023) {
        //配置Wifi网络参数
        operationID = mk_gw_server_taskModifyWifiNetworkInfoOperation;
    }else if (msgID == 1024) {
        //配置网络接口类型
        operationID = mk_gw_server_taskModifyNetworkTypeOperation;
    }else if (msgID == 1025) {
        //配置Ethernet网络参数
        operationID = mk_gw_server_taskModifyEthernetNetworkInfoOperation;
    }else if (msgID == 1030) {
        //配置MQTT参数
        operationID = mk_gw_server_taskModifyMqttInfoOperation;
    }else if (msgID == 1031) {
        //配置MQTT证书
        operationID = mk_gw_server_taskModifyMqttCertsOperation;
    }else if (msgID == 1040) {
        //设置扫描开关状态
        operationID = mk_gw_server_taskConfigScanSwitchStatusOperation;
    }else if (msgID == 1041) {
        //设置过滤逻辑
        operationID = mk_gw_server_taskConfigFilterRelationshipsOperation;
    }else if (msgID == 1042) {
        //设置过滤RSSI
        operationID = mk_gw_server_taskConfigFilterByRSSIOperation;
    }else if (msgID == 1043) {
        //设置过滤Mac
        operationID = mk_gw_server_taskConfigFilterByMacAddressOperation;
    }else if (msgID == 1044) {
        //设置过滤ADV Name
        operationID = mk_gw_server_taskConfigFilterByADVNameOperation;
    }else if (msgID == 1046) {
        //配置过滤iBeacon信息
        operationID = mk_gw_server_taskConfigFilterByBeaconOperation;
    }else if (msgID == 1047) {
        //配置过滤UID信息
        operationID = mk_gw_server_taskConfigFilterByUIDOperation;
    }else if (msgID == 1048) {
        //配置过滤Url信息
        operationID = mk_gw_server_taskConfigFilterByUrlOperation;
    }else if (msgID == 1049) {
        //配置过滤TLM信息
        operationID = mk_gw_server_taskConfigFilterByTLMOperation;
    }else if (msgID == 1050) {
        //配置bxp-deviceInfo过滤状态
        operationID = mk_gw_server_taskConfigFilterBXPDeviceInfoOperation;
    }else if (msgID == 1051) {
        //配置bxp-acc过滤状态
        operationID = mk_gw_server_taskConfigFilterBXPAccOperation;
    }else if (msgID == 1052) {
        //配置bxp-th过滤状态
        operationID = mk_gw_server_taskConfigFilterBXPTHOperation;
    }else if (msgID == 1053) {
        //配置bxp-button过滤信息
        operationID = mk_gw_server_taskConfigFilterBXPButtonOperation;
    }else if (msgID == 1054) {
        //配置bxp-tag过滤信息
        operationID = mk_gw_server_taskConfigFilterByTagOperation;
    }else if (msgID == 1055) {
        //配置PIR过滤信息
        operationID = mk_gw_server_taskConfigFilterByPirOperation;
    }else if (msgID == 1056) {
        //配置过滤Other信息
        operationID = mk_gw_server_taskConfigFilterByOtherDatasOperation;
    }else if (msgID == 1057) {
        //配置过滤Other信息
        operationID = mk_gw_server_taskConfigDuplicateDataFilterOperation;
    }else if (msgID == 1058) {
        //配置数据上报超时时间
        operationID = mk_gw_server_taskConfigDataReportTimeoutOperation;
    }else if (msgID == 1059) {
        //配置扫描数据上报内容选项
        operationID = mk_gw_server_taskConfigUploadDataOptionOperation;
    }else if (msgID == 1060) {
        //配置扫描过滤PHY
        operationID = mk_gw_server_taskConfigFilterByPHYOperation;
    }else if (msgID == 1061) {
        //配置iBeacon广播参数
        operationID = mk_gw_server_taskConfigAdvertiseBeaconParamsOperation;
    }else if (msgID == 1062) {
        //配置tof过滤
        operationID = mk_gw_server_taskConfigFilterByTofOperation;
    }else if (msgID == 1063) {
        //配置数据上报间隔
        operationID = mk_gw_server_taskConfigUploadDataIntervalOperation;
    }else if (msgID == 1200) {
        //网关断开指定mac地址的蓝牙设备
        operationID = mk_gw_server_taskDisconnectNormalBleDeviceWithMacOperation;
    }else if (msgID == 1202) {
        //指定BXP-Button设备DFU升级
        operationID = mk_gw_server_taskStartBXPButtonDfuWithMacOperation;
    }else if (msgID == 1209) {
        //配置蓝牙连接通信超时时间
        operationID = mk_gw_server_taskConfigBleCommunicateTimeoutOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)parseReadParamsWithJson:(NSDictionary *)json msgID:(NSInteger)msgID topic:(NSString *)topic {
    mk_gw_serverOperationID operationID = mk_gw_defaultServerOperationID;
    if (msgID == 2001) {
        //读取按键恢复出厂设置类型
        operationID = mk_gw_server_taskReadKeyResetTypeOperation;
    }else if (msgID == 2002) {
        //读取设备信息
        operationID = mk_gw_server_taskReadDeviceInfoOperation;
    }else if (msgID == 2003) {
        //读取网络状态上报间隔
        operationID = mk_gw_server_taskReadNetworkStatusReportIntervalOperation;
    }else if (msgID == 2005) {
        //读取网络重连超时时间
        operationID = mk_gw_server_taskReadNetworkReconnectTimeoutOperation;
    }else if (msgID == 2008) {
        //读取NTP服务器信息
        operationID = mk_gw_server_taskReadNTPServerOperation;
    }else if (msgID == 2009) {
        //读取UTC时间
        operationID = mk_gw_server_taskReadDeviceUTCTimeOperation;
    }else if (msgID == 2010) {
        //读取通信超时时间
        operationID = mk_gw_server_taskReadCommunicateTimeoutOperation;
    }else if (msgID == 2011) {
        //读取指示灯开关
        operationID = mk_gw_server_taskReadIndicatorLightStatusOperation;
    }else if (msgID == 2012) {
        //读取设备当前OTA状态
        operationID = mk_gw_server_taskReadOtaStatusOperation;
    }else if (msgID == 2020) {
        //读取设备当前连接的wifi信息
        operationID = mk_gw_server_taskReadWifiInfosOperation;
    }else if (msgID == 2023) {
        //读取Wifi网络参数
        operationID = mk_gw_server_taskReadWifiNetworkInfosOperation;
    }else if (msgID == 2024) {
        //读取网络接口选择
        operationID = mk_gw_server_taskReadNetworkTypeOperation;
    }else if (msgID == 2025) {
        //读取读取Ethernet网络参数
        operationID = mk_gw_server_taskReadEthernetNetworkInfosOperation;
    }else if (msgID == 2030) {
        //读取MQTT参数
        operationID = mk_gw_server_taskReadMQTTParamsOperation;
    }else if (msgID == 2040) {
        //读取扫描开关状态
        operationID = mk_gw_server_taskReadScanSwitchStatusOperation;
    }else if (msgID == 2041) {
        //读取过滤关系
        operationID = mk_gw_server_taskReadFilterRelationshipsOperation;
    }else if (msgID == 2042) {
        //读取过滤RSSI
        operationID = mk_gw_server_taskReadFilterByRSSIOperation;
    }else if (msgID == 2043) {
        //读取过滤Mac
        operationID = mk_gw_server_taskReadFilterByMacOperation;
    }else if (msgID == 2044) {
        //读取过滤ADV Name
        operationID = mk_gw_server_taskReadFilterADVNameRSSIOperation;
    }else if (msgID == 2045) {
        //读取RAW类型过滤开关
        operationID = mk_gw_server_taskReadFilterByRawDataStatusOperation;
    }else if (msgID == 2046) {
        //读取iBeacon过滤内容
        operationID = mk_gw_server_taskReadFilterByBeaconOperation;
    }else if (msgID == 2047) {
        //读取UID过滤内容
        operationID = mk_gw_server_taskReadFilterByUIDOperation;
    }else if (msgID == 2048) {
        //读取Url过滤内容
        operationID = mk_gw_server_taskReadFilterByUrlOperation;
    }else if (msgID == 2049) {
        //读取TLM过滤内容
        operationID = mk_gw_server_taskReadFilterByTLMOperation;
    }else if (msgID == 2050) {
        //读取bxp-deviceInfo过滤开关
        operationID = mk_gw_server_taskReadFilterBXPDeviceInfoStatusOperation;
    }else if (msgID == 2051) {
        //读取bxp-acc过滤开关
        operationID = mk_gw_server_taskReadFilterBXPAccStatusOperation;
    }else if (msgID == 2052) {
        //读取bxp-th过滤开关
        operationID = mk_gw_server_taskReadFilterBXPTHStatusOperation;
    }else if (msgID == 2053) {
        //读取bxp-button过滤内容
        operationID = mk_gw_server_taskReadFilterBXPButtonOperation;
    }else if (msgID == 2054) {
        //读取bxp-tag过滤内容
        operationID = mk_gw_server_taskReadFilterBXPTagOperation;
    }else if (msgID == 2055) {
        //读取Pir过滤内容
        operationID = mk_gw_server_taskReadFilterByPirOperation;
    }else if (msgID == 2056) {
        //读取过滤Other信息
        operationID = mk_gw_server_taskReadFilterOtherDatasOperation;
    }else if (msgID == 2057) {
        //读取扫描重复数据参数
        operationID = mk_gw_server_taskReadDuplicateDataFilterDatasOperation;
    }else if (msgID == 2058) {
        //读取数据上报超时时间
        operationID = mk_gw_server_taskReadDataReportTimeoutOperation;
    }else if (msgID == 2059) {
        //读取扫描数据上报内容选项
        operationID = mk_gw_server_taskReadUploadDataOptionOperation;
    }else if (msgID == 2060) {
        //读取Phy过滤类型
        operationID = mk_gw_server_taskReadFilterByPHYOperation;
    }else if (msgID == 2061) {
        //读取iBeacon广播参数
        operationID = mk_gw_server_taskReadAdvertiseBeaconParamsOperation;
    }else if (msgID == 2062) {
        //读取MK-TOF过滤
        operationID = mk_gw_server_taskReadFilterByTofOperation;
    }else if (msgID == 2063) {
        //读取数据上报间隔
        operationID = mk_gw_server_taskReadUploadDataIntervalOperation;
    }else if (msgID == 2201) {
        //读取网关蓝牙连接的状态
        operationID = mk_gw_server_taskReadGatewayBleConnectStatusOperation;
    }else if (msgID == 2209) {
        //读取蓝牙连接通信超时时间
        operationID = mk_gw_server_taskReadBleCommunicateTimeoutOperation;
    }
    return [self dataParserGetDataSuccess:json operationID:operationID];
}

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_gw_serverOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
