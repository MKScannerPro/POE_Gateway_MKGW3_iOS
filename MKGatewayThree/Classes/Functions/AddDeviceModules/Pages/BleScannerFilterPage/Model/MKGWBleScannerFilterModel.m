//
//  MKGWBleScannerFilterModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/31.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleScannerFilterModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKGWDeviceModel.h"

#import "MKGWInterface.h"
#import "MKGWInterface+MKGWConfig.h"

#import "MKGWDeviceMQTTParamsModel.h"

@interface MKGWBleScannerFilterModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWBleScannerFilterModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Read Rssi Error" block:failedBlock];
            return;
        }
        if (![self readMacAddress]) {
            [self operationFailedBlockWithMsg:@"Read Mac Address Error" block:failedBlock];
            return;
        }
        if (![self readAdvName]) {
            [self operationFailedBlockWithMsg:@"Read Adv Name Error" block:failedBlock];
            return;
        }
        if ([[MKGWDeviceMQTTParamsModel shared].deviceModel.deviceType isEqualToString:@"01"]) {
            if (![self readFilterInterval]) {
                [self operationFailedBlockWithMsg:@"Read Adv Name Error" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        NSString *msg = [self checkMsg];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        if (![self configFilterRssi]) {
            [self operationFailedBlockWithMsg:@"Config Rssi Error" block:failedBlock];
            return;
        }
        if (![self configMacAddress]) {
            [self operationFailedBlockWithMsg:@"Config Mac Address Error" block:failedBlock];
            return;
        }
        if (![self configAdvName]) {
            [self operationFailedBlockWithMsg:@"Config Adv Name Error" block:failedBlock];
            return;
        }
        if (![self configRelationShip]) {
            [self operationFailedBlockWithMsg:@"Config Relation Ship Error" block:failedBlock];
            return;
        }
        if ([[MKGWDeviceMQTTParamsModel shared].deviceModel.deviceType isEqualToString:@"01"]) {
            if (![self configFilterInterval]) {
                [self operationFailedBlockWithMsg:@"Config Adv Name Error" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readFilterRssi {
    __block BOOL success = NO;
    [MKGWInterface gw_readRssiFilterValueWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi = [returnData[@"result"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterRssi {
    __block BOOL success = NO;
    [MKGWInterface gw_configRssiFilterValue:self.rssi sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMacAddress {
    __block BOOL success = NO;
    [MKGWInterface gw_readFilterMACAddressListWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSArray *list = returnData[@"result"][@"macList"];
        if (ValidArray(list)) {
            self.macAddress = list[0];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMacAddress {
    __block BOOL success = NO;
    NSArray *macList = @[];
    if (ValidStr(self.macAddress)) {
        macList = @[self.macAddress];
    }
    [MKGWInterface gw_configFilterMACAddressList:macList
                             sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    }
                          failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdvName {
    __block BOOL success = NO;
    [MKGWInterface gw_readFilterAdvNameListWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSArray *list = returnData[@"result"][@"nameList"];
        if (ValidArray(list)) {
            self.advName = list[0];
        }
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvName {
    __block BOOL success = NO;
    NSArray *nameList = @[];
    if (ValidStr(self.advName)) {
        nameList = @[self.advName];
    }
    [MKGWInterface gw_configFilterAdvNameList:nameList
                             sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    }
                          failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRelationShip {
    __block BOOL success = NO;
    [MKGWInterface gw_configFilterRelationship:7
                             sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    }
                          failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFilterInterval {
    __block BOOL success = NO;
    [MKGWInterface gw_readFilterReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterInterval {
    __block BOOL success = NO;
    [MKGWInterface gw_configFilterReportInterval:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSString *)checkMsg {
    if (self.rssi < -127 || self.rssi > 0) {
        return @"Rssi Error";
    }
    if (self.macAddress.length % 2 != 0 || self.macAddress.length > 12) {
        return @"Mac Address Error";
    }
    if (self.advName.length > 20) {
        return @"Adv Name Error";
    }
    if ([[MKGWDeviceMQTTParamsModel shared].deviceModel.deviceType isEqualToString:@"01"]) {
        if (!ValidStr(self.interval) || [self.interval integerValue] < 0 || [self.interval integerValue] > 86400) {
            return @"Report Interval Error";
        }
    }
    return @"";
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"ScannerFilter"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("ScannerFilterQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
