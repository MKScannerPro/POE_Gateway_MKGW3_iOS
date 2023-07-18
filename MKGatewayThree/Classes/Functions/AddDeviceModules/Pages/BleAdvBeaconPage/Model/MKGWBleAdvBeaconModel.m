//
//  MKGWBleAdvBeaconModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/6/15.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleAdvBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKGWInterface.h"
#import "MKGWInterface+MKGWConfig.h"

@interface MKGWBleAdvBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWBleAdvBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAdvStatus]) {
            [self operationFailedBlockWithMsg:@"Read Advertise iBeacon Error" block:failedBlock];
            return;
        }
        if (![self readMajor]) {
            [self operationFailedBlockWithMsg:@"Read Major Error" block:failedBlock];
            return;
        }
        if (![self readMinor]) {
            [self operationFailedBlockWithMsg:@"Read Minor Error" block:failedBlock];
            return;
        }
        if (![self readUUID]) {
            [self operationFailedBlockWithMsg:@"Read UUID Error" block:failedBlock];
            return;
        }
        if (![self readInterval]) {
            [self operationFailedBlockWithMsg:@"Read Interval Error" block:failedBlock];
            return;
        }
        if (![self readTxPower]) {
            [self operationFailedBlockWithMsg:@"Read Tx Power Error" block:failedBlock];
            return;
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
        if (![self configAdvStatus]) {
            [self operationFailedBlockWithMsg:@"Config Advertise iBeacon Error" block:failedBlock];
            return;
        }
        if (!self.advertise) {
            moko_dispatch_main_safe(^{
                if (sucBlock) {
                    sucBlock();
                }
            });
            return;
        }
        if (![self configMajor]) {
            [self operationFailedBlockWithMsg:@"Config Major Error" block:failedBlock];
            return;
        }
        if (![self configMinor]) {
            [self operationFailedBlockWithMsg:@"Config Minor Error" block:failedBlock];
            return;
        }
        if (![self configUUID]) {
            [self operationFailedBlockWithMsg:@"Config UUID Error" block:failedBlock];
            return;
        }
        if (![self configInterval]) {
            [self operationFailedBlockWithMsg:@"Config Interval Error" block:failedBlock];
            return;
        }
        if (![self configTxPower]) {
            [self operationFailedBlockWithMsg:@"Config Tx Power Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readAdvStatus {
    __block BOOL success = NO;
    [MKGWInterface gw_readAdvertiseBeaconStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advertise = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvStatus {
    __block BOOL success = NO;
    [MKGWInterface gw_configAdvertiseBeaconStatus:self.advertise sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMajor {
    __block BOOL success = NO;
    [MKGWInterface gw_readBeaconMajorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.major = returnData[@"result"][@"major"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMajor {
    __block BOOL success = NO;
    [MKGWInterface gw_configBeaconMajor:[self.major integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMinor {
    __block BOOL success = NO;
    [MKGWInterface gw_readBeaconMinorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.minor = returnData[@"result"][@"minor"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMinor {
    __block BOOL success = NO;
    [MKGWInterface gw_configBeaconMinor:[self.minor integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readUUID {
    __block BOOL success = NO;
    [MKGWInterface gw_readBeaconUUIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.uuid = returnData[@"result"][@"uuid"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configUUID {
    __block BOOL success = NO;
    [MKGWInterface gw_configBeaconUUID:self.uuid sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readInterval {
    __block BOOL success = NO;
    [MKGWInterface gw_readBeaconAdvIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configInterval {
    __block BOOL success = NO;
    [MKGWInterface gw_configAdvInterval:[self.advInterval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTxPower {
    __block BOOL success = NO;
    [MKGWInterface gw_readBeaconTxPowerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.txPower = [returnData[@"result"][@"txPower"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTxPower {
    __block BOOL success = NO;
    [MKGWInterface gw_configTxPower:self.txPower sucBlock:^{
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
    if (!self.advertise) {
        return @"";
    }
    if (!ValidStr(self.major) || [self.major integerValue] < 0 || [self.major integerValue] > 65535) {
        return @"Major Error";
    }
    if (!ValidStr(self.minor) || [self.minor integerValue] < 0 || [self.minor integerValue] > 65535) {
        return @"Minor Error";
    }
    if (!ValidStr(self.uuid) || self.uuid.length != 32 || ![self.uuid regularExpressions:isHexadecimal]) {
        return @"UUID Error";
    }
    if (!ValidStr(self.advInterval) || [self.advInterval integerValue] < 1 || [self.advInterval integerValue] > 100) {
        return @"ADV Interval Error";
    }
    if (self.txPower < 0 || self.txPower > 15) {
        return @"Tx Power Error";
    }
    return @"";
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"AdvBeacon"
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
        _readQueue = dispatch_queue_create("AdvBeaconQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
