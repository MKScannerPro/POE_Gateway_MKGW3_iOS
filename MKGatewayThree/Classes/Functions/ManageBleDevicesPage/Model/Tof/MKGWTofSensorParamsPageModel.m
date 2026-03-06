//
//  MKGWTofSensorParamsPageModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import "MKGWTofSensorParamsPageModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@interface MKGWTofSensorParamsPageModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWTofSensorParamsPageModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSensorParams]) {
            [self operationFailedBlockWithMsg:@"Read Sensor Params Error" block:failedBlock];
            return;
        }
        if (![self readDistanceMode]) {
            [self operationFailedBlockWithMsg:@"Read Distance Mode Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configSensorParams]) {
            [self operationFailedBlockWithMsg:@"Config Sensor Params Error" block:failedBlock];
            return;
        }
        if (![self configDistanceMode]) {
            [self operationFailedBlockWithMsg:@"Config Distance Mode Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readSensorParams {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readMKTofSensorParamsWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                      macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                           topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                        sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"interval"]];
        self.count = [NSString stringWithFormat:@"%@",returnData[@"data"][@"count"]];
        self.time = [NSString stringWithFormat:@"%@",returnData[@"data"][@"time"]];
        dispatch_semaphore_signal(self.semaphore);
    }
                                                     failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSensorParams {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_configMKTofSensorParamsWithInterval:[self.interval integerValue]
                                                  sampleCount:[self.count integerValue]
                                                   sampleTime:[self.time integerValue]
                                                       bleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                   macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                        topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                     sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    }
                                                  failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
    
}

- (BOOL)readDistanceMode {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readMKTofRangingModeWithBleMacAddress:[MKGWManageBleDevicesManager shared].bleMac
                                                     macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                          topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                       sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.distanceMode = [returnData[@"data"][@"mode"] integerValue] - 1;
        dispatch_semaphore_signal(self.semaphore);
    }
                                                    failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDistanceMode {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_configMKTofRangingMode:self.distanceMode
                                          bleMac:[MKGWManageBleDevicesManager shared].bleMac
                                      macAddress:[MKScannerDeviceModelManager shared].macAddress
                                           topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                        sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    }
                                     failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
    
}

#pragma mark - private method


- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"TofSensorParamsPageModel"
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
        _readQueue = dispatch_queue_create("TofSensorParamsPageModelQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
