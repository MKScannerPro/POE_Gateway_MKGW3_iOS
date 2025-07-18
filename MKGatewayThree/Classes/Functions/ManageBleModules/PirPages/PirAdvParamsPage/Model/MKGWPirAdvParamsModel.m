//
//  MKGWPirAdvParamsModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWPirAdvParamsModel.h"

#import "MKMacroDefines.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWPirAdvParamsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWPirAdvParamsModel

- (void)readDataWithBleMac:(NSString *)bleMac
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAdvParams:bleMac]) {
            [self operationFailedBlockWithMsg:@"Read Adv Params Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithBleMac:(NSString *)bleMac
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configAdvParams:bleMac]) {
            [self operationFailedBlockWithMsg:@"Config Adv Params Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readAdvParams:(NSString *)bleMac {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readMKPirAdvParamsWithBleMacAddress:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"adv_interval"]];
        self.txPower = [self fetchTxPower:[returnData[@"data"][@"tx_power"] integerValue]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvParams:(NSString *)bleMac {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_configMKPirAdvParamsWithInterval:[self.interval integerValue] txPower:self.txPower bleMac:bleMac macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSInteger)fetchTxPower:(NSInteger)txPower {
    if (txPower == 0) {
        //4dBm
        return 7;
    }
    if (txPower == 1) {
        //0dBm
        return 6;
    }
    if (txPower == 2) {
        //-4dBm
        return 5;
    }
    if (txPower == 3) {
        //-8dBm
        return 4;
    }
    if (txPower == 4) {
        //-12dBm
        return 3;
    }
    if (txPower == 5) {
        //-16dBm
        return 2;
    }
    if (txPower == 6) {
        //-20dBm
        return 1;
    }
    return 0;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"advParams"
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
        _readQueue = dispatch_queue_create("BXPButtonAdvParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
