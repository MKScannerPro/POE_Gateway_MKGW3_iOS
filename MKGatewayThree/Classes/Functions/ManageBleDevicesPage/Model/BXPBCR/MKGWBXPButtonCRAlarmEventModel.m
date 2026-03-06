//
//  MKGWBXPButtonCRAlarmEventModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBXPButtonCRAlarmEventModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@interface MKGWBXPButtonCRAlarmEventModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWBXPButtonCRAlarmEventModel

- (void)dealloc {
    NSLog(@"MKGWBXPButtonCRAlarmEventModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)notifyAlarmData:(BOOL)isOn
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        for (NSInteger i = 0; i < 3; i ++) {
            if (![self notifyAlarmEvent:isOn eventType:i]) {
                [self operationFailedBlockWithMsg:@"Notify falied" block:failedBlock];
                return;
            }
        }
        if (isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveAlarmDatas:)
                                                         name:MKGWReceiveBXPBtnCRAlarmEventDataNotification
                                                       object:nil];
        }else {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)notifyAlarmEvent:(BOOL)notify
               eventType:(mk_gw_bxpcrAlarmEventType)eventType {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_BXPCRNotifyAlarmDataWithBleMac:[MKGWManageBleDevicesManager shared].bleMac alarmEventType:eventType notify:notify macAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
#pragma mark - Notes
- (void)receiveAlarmDatas:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].bleMac]) {
        return;
    }
    long long timestamp = [dataDic[@"timestamp"] longLongValue];
    NSInteger type = [dataDic[@"type"] integerValue];
    if (self.receiveAlarmDataBlock) {
        self.receiveAlarmDataBlock(timestamp, type);
    }
}

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
