//
//  MKGWNormalConnectedPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWNormalConnectedPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWNormalConnectedPageModel

- (void)dealloc {
    NSLog(@"MKGWNormalConnectedPageModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        _title = [MKScannerDeviceModelManager shared].deviceName;
        _serviceList = [MKGWManageBleDevicesManager shared].deviceBleInfo[@"data"][@"service_array"];
        [self addNotes];
    }
    return self;
}

- (void)disconnectWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_disconnectNormalBleDeviceWithBleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                                  failedBlock:failedBlock];
}

- (void)writeData:(NSString *)data
      serviceUUID:(NSString *)serverUUID
   characteristic:(NSString *)characteristic
         sucBlock:(void (^)(id returnData))sucBlock
      failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_writeValueToDeviceWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                        value:data serviceUUID:serverUUID
                                           characteristicUUID:characteristic
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:sucBlock
                                                  failedBlock:failedBlock];
}

- (void)readDataWithServiceUUID:(NSString *)serverUUID
                 characteristic:(NSString *)characteristic
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_readCharacteristicValueWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                       serviceUUID:serverUUID
                                                characteristicUUID:characteristic
                                                        macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                             topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                          sucBlock:sucBlock
                                                       failedBlock:failedBlock];
}

- (void)notify:(BOOL)notify
   serviceUUID:(NSString *)serverUUID
characteristic:(NSString *)characteristic
      sucBlock:(void (^)(id returnData))sucBlock
   failedBlock:(void (^)(NSError *error))failedBlock {
    [MKGWMQTTInterface gw_notifyCharacteristic:notify
                                 bleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                   serviceUUID:serverUUID
                            characteristicUUID:characteristic
                                    macAddress:[MKScannerDeviceModelManager shared].macAddress
                                         topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                      sucBlock:sucBlock
                                   failedBlock:failedBlock];
}

#pragma mark - notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].deviceBleInfo[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDisconnectBlock) {
        self.receiveDisconnectBlock();
    }
}

- (void)receiveDeviceDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].deviceBleInfo[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDeviceDatasBlock) {
        self.receiveDeviceDatasBlock(dataDic);
    }
}

- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGWReceiveGatewayDisconnectDeviceNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceDatas:)
                                                 name:MKGWReceiveGatewayConnectedDeviceDatasNotification
                                               object:nil];
}

@end
