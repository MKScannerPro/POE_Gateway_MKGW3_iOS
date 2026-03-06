//
//  MKGWFilterByBeaconModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWFilterByBeaconModel.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWFilterByBeaconModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWFilterByBeaconModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readFilterByBeacon]) {
            [self operationFailedBlockWithMsg:@"Read Filter iBeacon Error" block:failedBlock];
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
        NSString *msg = [self checkParams];
        if (ValidStr(msg)) {
            [self operationFailedBlockWithMsg:msg block:failedBlock];
            return;
        }
        if (![self configFilterByBeacon]) {
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
- (BOOL)readFilterByBeacon {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readFilterByBeaconWithMacAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = ([returnData[@"data"][@"switch_value"] integerValue] == 1);
        NSInteger tempMinMinor = [returnData[@"data"][@"min_minor"] integerValue];
        NSInteger tempMaxMinor = [returnData[@"data"][@"max_minor"] integerValue];
        NSInteger tempMinMajor = [returnData[@"data"][@"min_major"] integerValue];
        NSInteger tempMaxMajor = [returnData[@"data"][@"max_major"] integerValue];
        self.minMinor = [NSString stringWithFormat:@"%ld",(long)tempMinMinor];
        self.maxMinor = [NSString stringWithFormat:@"%ld",(long)tempMaxMinor];
        self.minMajor = [NSString stringWithFormat:@"%ld",(long)tempMinMajor];
        self.maxMajor = [NSString stringWithFormat:@"%ld",(long)tempMaxMajor];
        if (tempMinMinor == 0 && tempMaxMinor == 65535) {
            self.minMinor = @"";
            self.maxMinor = @"";
        }
        if (tempMinMajor == 0 && tempMaxMajor == 65535) {
            self.minMajor = @"";
            self.maxMajor = @"";
        }
        dispatch_semaphore_signal(self.semaphore);
        self.uuid = [returnData[@"data"][@"uuid"] lowercaseString];
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configFilterByBeacon {
    __block BOOL success = NO;
    
    NSInteger tempMinMinor = [self.minMinor integerValue];
    NSInteger tempMaxMinor = [self.maxMinor integerValue];
    NSInteger tempMinMajor = [self.minMajor integerValue];
    NSInteger tempMaxMajor = [self.maxMajor integerValue];
    
    if (!ValidStr(self.minMinor) && !ValidStr(self.maxMinor)) {
        tempMinMinor = 0;
        tempMaxMinor = 65535;
    }
    if (!ValidStr(self.minMajor) && !ValidStr(self.maxMajor)) {
        tempMinMajor = 0;
        tempMaxMajor = 65535;
    }
    
    [MKGWMQTTInterface gw_configFilterByBeacon:self.isOn minMinor:tempMinMinor maxMinor:tempMaxMinor minMajor:tempMinMajor maxMajor:tempMaxMajor uuid:self.uuid macAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"filterBeaconParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (NSString *)checkParams {
    if (!ValidStr(self.minMajor) && ValidStr(self.maxMajor)) {
        return @"Major error";
    }
    if (ValidStr(self.minMajor) && !ValidStr(self.maxMajor)) {
        return @"Major error";
    }
    if (!ValidStr(self.minMinor) && ValidStr(self.maxMinor)) {
        return @"Minor error";
    }
    if (ValidStr(self.minMinor) && !ValidStr(self.maxMinor)) {
        return @"Minor error";
    }
    if ([self.minMinor integerValue] < 0 || [self.minMinor integerValue] > 65535 || [self.maxMinor integerValue] < [self.minMinor integerValue] || [self.maxMinor integerValue] > 65535) {
        return @"Minor error";
    }
    if ([self.minMajor integerValue] < 0 || [self.minMajor integerValue] > 65535 || [self.maxMajor integerValue] < [self.minMajor integerValue] || [self.maxMajor integerValue] > 65535) {
        return @"Major error";
    }
    if (!self.uuid || ![self.uuid isKindOfClass:NSString.class]) {
        return @"UUID error";
    }
    if (ValidStr(self.uuid)) {
        if (![self.uuid regularExpressions:isHexadecimal] || self.uuid.length > 32 || self.uuid.length % 2 != 0) {
            return @"UUID error";
        }
    }
    return @"";
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
        _readQueue = dispatch_queue_create("filterBeaconQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
