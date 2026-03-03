//
//  MKGWDeviceInfoModel.m
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/31.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKGWDeviceInfoModel.h"

#import "MKMacroDefines.h"

#import "MKScannerDeviceModelManager.h"

#import "MKGWMQTTInterface.h"

@interface MKGWDeviceInfoModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKGWDeviceInfoModel

- (void)readDataWithSucBlock:(void (^)(NSArray <MKScannerDeviceInfoModel *>*dataList))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readDeviceInfo]) {
            [self operationFailedBlockWithMsg:@"Read Data Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock([self fetchDataList]);
        });
    });
}

#pragma mark - interface
- (BOOL)readDeviceInfo {
    __block BOOL success = NO;
    [MKGWMQTTInterface gw_readDeviceInfoWithMacAddress:[MKScannerDeviceModelManager shared].macAddress topic:[MKScannerDeviceModelManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceName = returnData[@"data"][@"device_name"];
        self.productMode = returnData[@"data"][@"product_model"];
        self.manu = returnData[@"data"][@"company_name"];
        self.firmware = returnData[@"data"][@"firmware_version"];
        self.bleFirmware = returnData[@"data"][@"sl_ble_version"];
        self.hardware = returnData[@"data"][@"hardware_version"];
        self.software = returnData[@"data"][@"software_version"];
        self.ethernetMac = returnData[@"data"][@"eth_mac"];
        self.btMac = returnData[@"data"][@"ble_mac"];
        self.wifiStaMac = [MKScannerDeviceModelManager shared].macAddress;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"deviceInformation"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
}

- (NSArray <MKScannerDeviceInfoModel *>*)fetchDataList {
    NSMutableArray *list = [NSMutableArray array];
    MKScannerDeviceInfoModel *cellModel1 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel1.key = @"Device name";
    cellModel1.value = self.deviceName;
    [list addObject:cellModel1];
    
    MKScannerDeviceInfoModel *cellModel2 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel2.key = @"Product model";
    cellModel2.value = self.productMode;
    [list addObject:cellModel2];
    
    MKScannerDeviceInfoModel *cellModel3 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel3.key = @"Manufacturer";
    cellModel3.value = self.manu;
    [list addObject:cellModel3];
    
    MKScannerDeviceInfoModel *cellModel4 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel4.key = @"Hardware version";
    cellModel4.value = self.hardware;
    [list addObject:cellModel4];
    
    MKScannerDeviceInfoModel *cellModel5 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel5.key = @"Software version";
    cellModel5.value = self.software;
    [list addObject:cellModel5];
    
    MKScannerDeviceInfoModel *cellModel6 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel6.key = ([MKScannerDeviceModelManager shared].isV2 ? @"WIFI Firmware version" : @"Firmware version");
    cellModel6.value = self.firmware;
    [list addObject:cellModel6];
    
    if ([MKScannerDeviceModelManager shared].isV2) {
        MKScannerDeviceInfoModel *cellModel10 = [[MKScannerDeviceInfoModel alloc] init];
        cellModel10.key = @"BLE Firmware version";
        cellModel10.value = self.bleFirmware;
        [list addObject:cellModel10];
    }
    
    MKScannerDeviceInfoModel *cellModel7 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel7.key = @"WIFI MAC";
    cellModel7.value = self.wifiStaMac;
    [list addObject:cellModel7];
    
    MKScannerDeviceInfoModel *cellModel8 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel8.key = @"Ethernet MAC";
    cellModel8.value = self.ethernetMac;
    [list addObject:cellModel8];
    
    MKScannerDeviceInfoModel *cellModel9 = [[MKScannerDeviceInfoModel alloc] init];
    cellModel9.key = @"BT MAC";
    cellModel9.value = self.btMac;
    [list addObject:cellModel9];
    
    return list;
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
        _readQueue = dispatch_queue_create("deviceInfoParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
