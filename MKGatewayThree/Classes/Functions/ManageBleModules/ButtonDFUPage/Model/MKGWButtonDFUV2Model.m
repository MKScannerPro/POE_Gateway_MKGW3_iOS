//
//  MKGWButtonDFUV2Model.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/6/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWButtonDFUV2Model.h"

#import "MKMacroDefines.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWButtonDFUV2Model ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWButtonDFUV2Model

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"File URL error" block:failedBlock];
            return;
        }
        if (![self startDfu]) {
            [self operationFailedBlockWithMsg:@"Setup failed!" block:failedBlock];
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
- (BOOL)startDfu {
    __block BOOL success = NO;
    NSString *password = @"";
    if (self.type == 7 || self.type == 8) {
        password = @"MOKOMOKO";
    }
    [MKGWMQTTInterface gw_startBXPDfuWithBeaconType:self.type firmwareUrl:self.firmwareUrl dataUrl:self.dataUrl dfuList:@[@{@"mac":self.bleMac,@"password":password}] macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)validParams {
    if (self.type < 1 || self.type > 8 || !ValidStr(self.bleMac)) {
        return NO;
    }
    if (!ValidStr(self.firmwareUrl) || self.firmwareUrl.length > 256) {
        return NO;
    }
    if (self.type != 5 && self.type != 6 && !ValidStr(self.dataUrl) || self.dataUrl.length > 256) {
        return NO;
    }
    return YES;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"buttonDFUParams"
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
        _readQueue = dispatch_queue_create("buttonDFUQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
