//
//  MKGWBXPButtonCRAlarmEventModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRAlarmEventModel.h"

#import "MKMacroDefines.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWBXPButtonCRAlarmEventModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWBXPButtonCRAlarmEventModel

- (void)notifyDataWithBleMac:(NSString *)bleMac
                      notify:(BOOL)notify
                    sucBlock:(nonnull void (^)(void))sucBlock
                 failedBlock:(nonnull void (^)(NSError * _Nonnull))failedBlock {
    dispatch_async(self.readQueue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            if (![self notifyAlarmEvent:bleMac notify:notify eventType:i]) {
                [self operationFailedBlockWithMsg:@"Notify falied" block:failedBlock];
                return;
            }
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)notifyAlarmEvent:(NSString *)bleMac
                  notify:(BOOL)notify
               eventType:(mk_gw_bxpcrAlarmEventType)eventType {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_BXPCRNotifyAlarmDataWithBleMac:bleMac alarmEventType:eventType notify:notify macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"BXPCRAlarmEventParams"
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
        _readQueue = dispatch_queue_create("BXPCRAlarmEventQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
