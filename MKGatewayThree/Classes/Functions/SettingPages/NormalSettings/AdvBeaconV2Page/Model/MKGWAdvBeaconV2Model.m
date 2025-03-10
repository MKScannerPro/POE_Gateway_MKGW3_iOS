//
//  MKGWAdvBeaconV2Model.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/14.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWAdvBeaconV2Model.h"

#import "MKMacroDefines.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWAdvBeaconParamsV2Model : NSObject<gw_advertiseBeaconV2Protocol>

@property (nonatomic, assign)BOOL advertise;

@property (nonatomic, assign)NSInteger major;

@property (nonatomic, assign)NSInteger minor;

@property (nonatomic, copy)NSString *uuid;

@property (nonatomic, assign)NSInteger advInterval;

/*
 0：-24dbm
 1：-21dbm
 2：-18dbm
 3：-15dbm
 4：-12dbm
 5：-9dbm
 6：-6dbm
 7：-3dbm
 8：0dbm
 9：3dbm
 10：6dbm
 11：9dbm
 12：12dbm
 13：15dbm
 14：18dbm
 15：21dbm
 */
@property (nonatomic, assign)NSInteger txPower;

@property (nonatomic, assign)NSInteger rssi1M;

@property (nonatomic, assign)BOOL connectable;

@end

@implementation MKGWAdvBeaconParamsV2Model
@end

@interface MKGWAdvBeaconV2Model ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWAdvBeaconV2Model

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readAdvBeaconDatas]) {
            [self operationFailedBlockWithMsg:@"Read Advertise iBeacon Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self configAdvBeaconDatas]) {
            [self operationFailedBlockWithMsg:@"Config Advertise iBeacon Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

#pragma mark - interface
- (BOOL)readAdvBeaconDatas {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readAdvertiseBeaconParamsWithMacAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advertise = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.major = [NSString stringWithFormat:@"%@",returnData[@"data"][@"major"]];
        self.minor = [NSString stringWithFormat:@"%@",returnData[@"data"][@"minor"]];
        self.uuid = SafeStr(returnData[@"data"][@"uuid"]);
        self.advInterval = [NSString stringWithFormat:@"%@",returnData[@"data"][@"adv_interval"]];
        self.txPower = [returnData[@"data"][@"tx_power"] integerValue];
        self.connectable = ([returnData[@"data"][@"connectable"] integerValue] == 1);
        self.rssi1m = [returnData[@"data"][@"rssi_1m"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvBeaconDatas {
    __block BOOL success = NO;
    
    MKGWAdvBeaconParamsV2Model *dataModel = [[MKGWAdvBeaconParamsV2Model alloc] init];
    dataModel.advertise = self.advertise;
    dataModel.major = [self.major integerValue];
    dataModel.minor = [self.minor integerValue];
    dataModel.uuid = self.uuid;
    dataModel.advInterval = [self.advInterval integerValue];
    dataModel.txPower = self.txPower;
    dataModel.rssi1M = self.rssi1m;
    dataModel.connectable = self.connectable;
    
    [MKGWMQTTInterface gw_configV2AdvertiseBeaconParams:dataModel macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"PowerMetering"
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
        _readQueue = dispatch_queue_create("PowerMeteringQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
