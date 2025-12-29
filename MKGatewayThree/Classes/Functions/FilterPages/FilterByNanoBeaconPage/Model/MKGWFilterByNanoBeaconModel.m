//
//  MKGWFilterByNanoBeaconModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/10/20.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import "MKGWFilterByNanoBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKGWDeviceModeManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWFilterByNanoBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWFilterByNanoBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterInformation]) {
            [self operationFailedBlockWithMsg:@"Read Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithManufactureList:(NSArray <NSString *>*)manufactureList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams:manufactureList]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configFilterInformation:manufactureList]) {
            [self operationFailedBlockWithMsg:@"Config Data Error" block:failedBlock];
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

- (BOOL)readFilterInformation {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readFilterByNanoBeaconWithMacAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        self.triggerType = [returnData[@"data"][@"adv_type"] integerValue];
        if (ValidArray(returnData[@"data"][@"mf_id"])) {
            self.manufactureList = returnData[@"data"][@"mf_id"];
        }
        
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterInformation:(NSArray <NSString *>*)list {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_configFilterByNanoBeacon:self.isOn advType:self.triggerType manufactureIDList:list macAddress:[MKGWDeviceModeManager shared].macAddress topic:[MKGWDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"FilterByNanoBeaconParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams:(NSArray <NSString *>*)manufactureList {
    if (manufactureList.count > 10) {
        return NO;
    }
    for (NSString *manufacture in manufactureList) {
        if ((manufacture.length != 4) || ![manufacture regularExpressions:isHexadecimal]) {
            return NO;
        }
    }
    return YES;
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
        _readQueue = dispatch_queue_create("FilterByMacQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
