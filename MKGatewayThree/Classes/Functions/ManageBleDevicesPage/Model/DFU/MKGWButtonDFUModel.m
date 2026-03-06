//
//  MKGWButtonDFUModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWButtonDFUModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"

#import "MKGWManageBleDevicesManager.h"

@implementation MKGWButtonDFUModel

- (void)dealloc {
    NSLog(@"MKGWButtonDFUModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    if (self = [super init]) {
        [self addNotes];
    }
    return self;
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(self.firmwareUrl) || self.firmwareUrl.length > 256 || !ValidStr(self.dataUrl) || self.dataUrl.length > 256) {
        if (failedBlock) {
            NSError *error = [[NSError alloc] initWithDomain:@"buttonDFUParams"
                                                        code:-999
                                                    userInfo:@{@"errorInfo":@"File URL error"}];
            failedBlock(error);
        }
        return;
    }
    [MKGWMQTTInterface gw_startBXPButtonDfuWithFirmwareUrl:self.firmwareUrl
                                                   dataUrl:self.dataUrl
                                                    bleMac:[MKGWManageBleDevicesManager shared].bleMac
                                                macAddress:[MKScannerDeviceModelManager shared].macAddress
                                                     topic:[MKScannerDeviceModelManager shared].subscribedTopic
                                                  sucBlock:^(id  _Nonnull returnData) {
        if (sucBlock) {
            sucBlock();
        }
    }
                                               failedBlock:failedBlock];
}

#pragma mark - interface

- (BOOL)validParams {
    if (!ValidStr(self.firmwareUrl) || self.firmwareUrl.length > 256 || !ValidStr(self.dataUrl) || self.dataUrl.length > 256) {
        return NO;
    }
    return YES;
}

#pragma mark - Notes
- (void)receiveDisconnect:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    NSDictionary *dataDic = user[@"data"];
    if (![dataDic[@"mac"] isEqualToString:[MKGWManageBleDevicesManager shared].bleMac]) {
        return;
    }
    if (self.deviceDisconnectBlock) {
        self.deviceDisconnectBlock([MKScannerDeviceModelManager shared].macAddress, [MKGWManageBleDevicesManager shared].bleMac);
    }
}

- (void)receiveDfuProgress:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    if (!ValidStr(user[@"data"][@"mac"]) || ![[MKGWManageBleDevicesManager shared].bleMac isEqualToString:user[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDfuProgressBlock) {
        NSString *percent = [NSString stringWithFormat:@"%@",user[@"data"][@"percent"]];
        self.receiveDfuProgressBlock([MKScannerDeviceModelManager shared].macAddress, [MKGWManageBleDevicesManager shared].bleMac, percent);
    }
}

- (void)receiveDfuResult:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"device_info"][@"mac"]) || ![[MKScannerDeviceModelManager shared].macAddress isEqualToString:user[@"device_info"][@"mac"]]) {
        return;
    }
    if (!ValidStr(user[@"data"][@"mac"]) || ![[MKGWManageBleDevicesManager shared].bleMac isEqualToString:user[@"data"][@"mac"]]) {
        return;
    }
    if (self.receiveDfuResultBlock) {
        NSInteger result = [user[@"data"][@"result_code"] integerValue];
        self.receiveDfuResultBlock([MKScannerDeviceModelManager shared].macAddress, [MKGWManageBleDevicesManager shared].bleMac, result);
    }
}

#pragma mark - private method
- (void)addNotes {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDfuProgress:)
                                                 name:MKGWReceiveBxpButtonDfuProgressNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDfuResult:)
                                                 name:MKGWReceiveBxpButtonDfuResultNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDisconnect:)
                                                 name:MKGWReceiveGatewayDisconnectBXPButtonNotification
                                               object:nil];
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"buttonDFUParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

@end
