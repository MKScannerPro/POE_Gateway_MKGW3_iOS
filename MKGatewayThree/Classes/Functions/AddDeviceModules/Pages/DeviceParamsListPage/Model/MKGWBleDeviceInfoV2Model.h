//
//  MKGWBleDeviceInfoV2Model.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/16.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerBleDeviceInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBleDeviceInfoV2Model : NSObject<MKScannerBleDeviceInfoProtocol>

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *productMode;

@property (nonatomic, copy)NSString *manu;

@property (nonatomic, copy)NSString *bleFirmware;

@property (nonatomic, copy)NSString *wifiFirmware;

@property (nonatomic, copy)NSString *software;

@property (nonatomic, copy)NSString *hardware;

@property (nonatomic, copy)NSString *ethernetMac;

@property (nonatomic, copy)NSString *wifiStaMac;

@property (nonatomic, copy)NSString *btMac;

- (void)readDataWithSucBlock:(void (^)(NSArray <MKScannerBleDeviceInfoModel *>*dataList))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
