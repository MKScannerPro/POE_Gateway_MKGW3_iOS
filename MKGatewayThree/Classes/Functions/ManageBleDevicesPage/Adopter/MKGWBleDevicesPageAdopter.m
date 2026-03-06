//
//  MKGWBleDevicesPageAdopter.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleDevicesPageAdopter.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

#import "MKScannerBXPButtonCRController.h"
#import "MKScannerBXPButtonController.h"
#import "MKScannerBXPCController.h"
#import "MKScannerBXPDController.h"
#import "MKScannerBXPSController.h"
#import "MKScannerBXPTController.h"
#import "MKScannerPirController.h"
#import "MKScannerTofController.h"
#import "MKScannerNormalConnectedController.h"

#import "MKGWBXPButtonCRPageModel.h"
#import "MKGWBXPButtonPageModel.h"
#import "MKGWBXPCPageModel.h"
#import "MKGWBXPDPageModel.h"
#import "MKGWBXPSPageModel.h"
#import "MKGWBXPTPageModel.h"
#import "MKGWPirPageModel.h"
#import "MKGWTofPageModel.h"
#import "MKGWNormalConnectedPageModel.h"

@implementation MKGWBleDevicesPageAdopter

+ (UIViewController *)loadBXPBCRPage {
    MKGWBXPButtonCRPageModel *model = [[MKGWBXPButtonCRPageModel alloc] init];
    MKScannerBXPButtonCRController *vc = [[MKScannerBXPButtonCRController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPBDPage {
    MKGWBXPButtonPageModel *model = [[MKGWBXPButtonPageModel alloc] init];
    MKScannerBXPButtonController *vc = [[MKScannerBXPButtonController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPCPage {
    MKGWBXPCPageModel *model = [[MKGWBXPCPageModel alloc] init];
    MKScannerBXPCController *vc = [[MKScannerBXPCController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPDPage {
    MKGWBXPDPageModel *model = [[MKGWBXPDPageModel alloc] init];
    MKScannerBXPDController *vc = [[MKScannerBXPDController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPSPage {
    MKGWBXPSPageModel *model = [[MKGWBXPSPageModel alloc] init];
    MKScannerBXPSController *vc = [[MKScannerBXPSController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadBXPTPage {
    MKGWBXPTPageModel *model = [[MKGWBXPTPageModel alloc] init];
    MKScannerBXPTController *vc = [[MKScannerBXPTController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadMKPirPage {
    MKGWPirPageModel *model = [[MKGWPirPageModel alloc] init];
    MKScannerPirController *vc = [[MKScannerPirController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadMKTofPage {
    MKGWTofPageModel *model = [[MKGWTofPageModel alloc] init];
    MKScannerTofController *vc = [[MKScannerTofController alloc] initWithProtocol:model];
    return vc;
}

+ (UIViewController *)loadNormalConnectedPage {
    MKGWNormalConnectedPageModel *model = [[MKGWNormalConnectedPageModel alloc] init];
    MKScannerNormalConnectedController *vc = [[MKScannerNormalConnectedController alloc] initWithProtocol:model];
    return vc;
}

+ (void)connectPeripheral:(NSString *)bleMac
                     type:(MKGWManageBleDevicesType)type
                 password:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (type == MKGWManageBleDevicesTypeBXPBD) {
        //BXP-B-D
        [self connectBXPButtonWithPassword:password
                                    bleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPBCR) {
        //BXP-B-CR
        [self connectBXPButtonCRWithPassword:password
                                      bleMac:bleMac
                                    sucBlock:sucBlock
                                 failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPC) {
        //BXP-C
        [self connectBXPCWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPD) {
        //BXP-D
        [self connectBXPDWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPT) {
        //BXP-T
        [self connectBXPTWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPS) {
        //BXP-S
        [self connectBXPSWithPassword:password
                               bleMac:bleMac
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypePIR) {
        //MK Pir
        [self connectMKPirWithPassword:password
                                bleMac:bleMac
                              sucBlock:sucBlock
                           failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeTOF) {
        //MK Tof
        [self connectMKTofWithPassword:password
                                bleMac:bleMac
                              sucBlock:sucBlock
                           failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeOther) {
        //Normal Connected
        [self connectNormalDeviceWithBleMac:bleMac
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
        return;
    }
    if (failedBlock) {
        failedBlock([self getErrorWithMsg:@"Type error"]);
    }
}

+ (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac
                                     type:(MKGWManageBleDevicesType)type
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    if (type == MKGWManageBleDevicesTypeBXPBD) {
        //BXP-B-D
        [self readBXPButtonDeviceInfoWithBleMac:bleMac
                                       sucBlock:sucBlock
                                    failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPBCR) {
        //BXP-B-CR
        [self readBXPButtonCRDeviceInfoWithBleMac:bleMac
                                         sucBlock:sucBlock
                                      failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPC) {
        //BXP-C
        [self readBXPCDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPD) {
        //BXP-D
        [self readBXPDDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPT) {
        //BXP-T
        [self readBXPTDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeBXPS) {
        //BXP-S
        [self readBXPSDeviceInfoWithBleMac:bleMac
                                  sucBlock:sucBlock
                               failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypePIR) {
        //MK Pir
        [self readMKPIRDeviceInfoWithBleMac:bleMac
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeTOF) {
        //MK Tof
        [self readMKTOFDeviceInfoWithBleMac:bleMac
                                   sucBlock:sucBlock
                                failedBlock:failedBlock];
        return;
    }
    if (type == MKGWManageBleDevicesTypeOther) {
        //Normal Connected
        [self readNormalDeviceInfoWithBleMac:bleMac
                                    sucBlock:sucBlock
                                 failedBlock:failedBlock];
        return;
    }
    if (failedBlock) {
        failedBlock([self getErrorWithMsg:@"Type error"]);
    }
}

#pragma mark - 连接设备
+ (void)connectBXPButtonWithPassword:(NSString *)password
                              bleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectBXPButtonWithPassword:password
                                                bleMac:bleMac
                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                              sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                           failedBlock:failedBlock];
}

+ (void)connectBXPButtonCRWithPassword:(NSString *)password
                                bleMac:(NSString *)bleMac
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectBXPButtonCRWithPassword:password
                                                  bleMac:bleMac
                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                             failedBlock:failedBlock];
}

+ (void)connectBXPCWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectBXPCWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectBXPDWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectBXPDWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectBXPTWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectBXPTWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectBXPSWithPassword:(NSString *)password
                         bleMac:(NSString *)bleMac
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectBXPSWithPassword:password
                                           bleMac:bleMac
                                       macAddress:[MKScannerDeviceModelManager shared].macAddress
                                            topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                         sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                      failedBlock:failedBlock];
}

+ (void)connectMKPirWithPassword:(NSString *)password
                          bleMac:(NSString *)bleMac
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectMKPirWithPassword:password
                                            bleMac:bleMac
                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                       failedBlock:failedBlock];
}

+ (void)connectMKTofWithPassword:(NSString *)password
                          bleMac:(NSString *)bleMac
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectMKTofWithPassword:password
                                            bleMac:bleMac
                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                          sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                       failedBlock:failedBlock];
}

+ (void)connectNormalDeviceWithBleMac:(NSString *)bleMac
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_connectNormalBleDeviceWithBleMac:bleMac
                                                macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                     topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                  sucBlock:^(id  _Nonnull returnData) {
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            //连接失败
            if (failedBlock) {
                failedBlock([self getErrorWithMsg:returnData[@"data"][@"result_msg"]]);
            }
            return;
        }
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        
        if (sucBlock) {
            sucBlock();
        }
    }
                                               failedBlock:failedBlock];
}

#pragma mark - 读取设备信息
+ (void)readBXPButtonDeviceInfoWithBleMac:(NSString *)bleMac
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPButtonConnectedDeviceInfoWithBleMacAddress:bleMac
                                                                 macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                      topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                   sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                                failedBlock:failedBlock];
}

+ (void)readBXPButtonCRDeviceInfoWithBleMac:(NSString *)bleMac
                                   sucBlock:(void (^)(void))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPButtonCRConnectedDeviceInfoWithBleMacAddress:bleMac
                                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                     sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                                  failedBlock:failedBlock];
}

+ (void)readBXPCDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPCConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readBXPDDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPDConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readBXPTDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPTConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readBXPSDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readBXPSConnectedDeviceInfoWithBleMacAddress:bleMac
                                                            macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                 topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                              sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                           failedBlock:failedBlock];
}

+ (void)readMKPIRDeviceInfoWithBleMac:(NSString *)bleMac
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readMKPirConnectedDeviceInfoWithBleMacAddress:bleMac
                                                             macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                            failedBlock:failedBlock];
}

+ (void)readMKTOFDeviceInfoWithBleMac:(NSString *)bleMac
                            sucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readMKTofConnectedDeviceInfoWithBleMacAddress:bleMac
                                                             macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                  topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                               sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                            failedBlock:failedBlock];
}

+ (void)readNormalDeviceInfoWithBleMac:(NSString *)bleMac
                              sucBlock:(void (^)(void))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readNormalConnectedDeviceInfoWithBleMacAddress:bleMac
                                                              macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                                   topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                                sucBlock:^(id  _Nonnull returnData) {
        [MKGWManageBleDevicesManager shared].deviceBleInfo = returnData;
        if (sucBlock) {
            sucBlock();
        }
    }
                                                             failedBlock:failedBlock];
}

+ (NSError *)getErrorWithMsg:(NSString *)msg {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.ManageBleDevicesManager"
                                                code:-99
                                            userInfo:@{@"errorInfo":msg}];
    return error;
}

@end
