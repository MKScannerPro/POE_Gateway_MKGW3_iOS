//
//  MKGWPirSensorParamsPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWPirSensorParamsPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@interface MKGWPirSensorParamsPageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWPirSensorParamsPageModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSensitivity]) {
            [self operationFailedBlockWithMsg:@"Read Sensitivity Error" block:failedBlock];
            return;
        }
        if (![self readDelay]) {
            [self operationFailedBlockWithMsg:@"Read Delay Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configSensitivity]) {
            [self operationFailedBlockWithMsg:@"Config Sensitivity Error" block:failedBlock];
            return;
        }
        if (![self configDelay]) {
            [self operationFailedBlockWithMsg:@"Config Delay Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readSensitivity {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readMKPirSensorSensitivityWithBleMac:[MKGWManageBleDevicesManager shared].bleMac macAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sensitivity = [returnData[@"data"][@"sensitivity"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSensitivity {
    __block BOOL success = NO;
    
    [MKGWMQTTInterface gw_configMKPirSensorSensitivityWithBleMac:[MKGWManageBleDevicesManager shared].bleMac sensitivity:self.sensitivity macAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
    
}

- (BOOL)readDelay {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readMKPirSensorDelayWithBleMac:[MKGWManageBleDevicesManager shared].bleMac macAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.delay = [returnData[@"data"][@"delay_status"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDelay {
    __block BOOL success = NO;
    
    [MKGWMQTTInterface gw_configMKPirSensorDelayWithBleMac:[MKGWManageBleDevicesManager shared].bleMac delay:self.delay macAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
    
}

#pragma mark - private method


- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"PirSensorParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("PirSensorParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
