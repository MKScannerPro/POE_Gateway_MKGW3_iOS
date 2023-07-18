//
//  CBPeripheral+MKGWAdd.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKGWAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gw_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gw_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gw_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gw_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *gw_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *gw_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *gw_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *gw_custom;

- (void)gw_updateCharacterWithService:(CBService *)service;

- (void)gw_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)gw_connectSuccess;

- (void)gw_setNil;

@end

NS_ASSUME_NONNULL_END
