//
//  MKGWCommunicateModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/11.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWCommunicateModel.h"

#import "MKMacroDefines.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWCommunicateModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWCommunicateModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readCommunicateTimeout]) {
            [self operationFailedBlockWithMsg:@"Read Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configCommunicateTimeout]) {
            [self operationFailedBlockWithMsg:@"Config Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readCommunicateTimeout {
    __block BOOL success = NO;
    
    if ([MKGWDeviceModeManager shared].isV2) {
        [MKGWMQTTInterface gw_readBleCommunicateTimeoutWithMacAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            success = YES;
            self.timeout = [NSString stringWithFormat:@"%@",returnData[@"data"][@"timeout"]];
            dispatch_semaphore_signal(self.semaphore);
        } failedBlock:^(NSError * _Nonnull error) {
            dispatch_semaphore_signal(self.semaphore);
        }];
    }else {
        [MKGWMQTTInterface gw_readCommunicateTimeoutWithMacAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            success = YES;
            self.timeout = [NSString stringWithFormat:@"%@",returnData[@"data"][@"timeout"]];
            dispatch_semaphore_signal(self.semaphore);
        } failedBlock:^(NSError * _Nonnull error) {
            dispatch_semaphore_signal(self.semaphore);
        }];
    }
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCommunicateTimeout {
    __block BOOL success = NO;
    if ([MKGWDeviceModeManager shared].isV2) {
        [MKGWMQTTInterface gw_configBleCommunicateTimeout:[self.timeout integerValue] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            success = YES;
            dispatch_semaphore_signal(self.semaphore);
        } failedBlock:^(NSError * _Nonnull error) {
            dispatch_semaphore_signal(self.semaphore);
        }];
    }else {
        [MKGWMQTTInterface gw_configCommunicationTimeout:[self.timeout integerValue] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            success = YES;
            dispatch_semaphore_signal(self.semaphore);
        } failedBlock:^(NSError * _Nonnull error) {
            dispatch_semaphore_signal(self.semaphore);
        }];
    }
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"communicateTimeout"
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
        _readQueue = dispatch_queue_create("communicateTimeoutParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
