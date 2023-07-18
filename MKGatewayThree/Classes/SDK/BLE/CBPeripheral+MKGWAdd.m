//
//  CBPeripheral+MKGWAdd.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKGWAdd.h"

#import <objc/runtime.h>

static const char *gw_manufacturerKey = "gw_manufacturerKey";
static const char *gw_deviceModelKey = "gw_deviceModelKey";
static const char *gw_hardwareKey = "gw_hardwareKey";
static const char *gw_softwareKey = "gw_softwareKey";
static const char *gw_firmwareKey = "gw_firmwareKey";

static const char *gw_passwordKey = "gw_passwordKey";
static const char *gw_disconnectTypeKey = "gw_disconnectTypeKey";
static const char *gw_customKey = "gw_customKey";

static const char *gw_passwordNotifySuccessKey = "gw_passwordNotifySuccessKey";
static const char *gw_disconnectTypeNotifySuccessKey = "gw_disconnectTypeNotifySuccessKey";
static const char *gw_customNotifySuccessKey = "gw_customNotifySuccessKey";

@implementation CBPeripheral (MKGWAdd)

- (void)gw_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &gw_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &gw_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &gw_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &gw_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &gw_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &gw_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &gw_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &gw_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)gw_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &gw_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &gw_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &gw_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)gw_connectSuccess {
    if (![objc_getAssociatedObject(self, &gw_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &gw_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &gw_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.gw_hardware || !self.gw_firmware) {
        return NO;
    }
    if (!self.gw_password || !self.gw_disconnectType || !self.gw_custom) {
        return NO;
    }
    return YES;
}

- (void)gw_setNil {
    objc_setAssociatedObject(self, &gw_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &gw_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &gw_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &gw_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)gw_manufacturer {
    return objc_getAssociatedObject(self, &gw_manufacturerKey);
}

- (CBCharacteristic *)gw_deviceModel {
    return objc_getAssociatedObject(self, &gw_deviceModelKey);
}

- (CBCharacteristic *)gw_hardware {
    return objc_getAssociatedObject(self, &gw_hardwareKey);
}

- (CBCharacteristic *)gw_software {
    return objc_getAssociatedObject(self, &gw_softwareKey);
}

- (CBCharacteristic *)gw_firmware {
    return objc_getAssociatedObject(self, &gw_firmwareKey);
}

- (CBCharacteristic *)gw_password {
    return objc_getAssociatedObject(self, &gw_passwordKey);
}

- (CBCharacteristic *)gw_disconnectType {
    return objc_getAssociatedObject(self, &gw_disconnectTypeKey);
}

- (CBCharacteristic *)gw_custom {
    return objc_getAssociatedObject(self, &gw_customKey);
}

@end
