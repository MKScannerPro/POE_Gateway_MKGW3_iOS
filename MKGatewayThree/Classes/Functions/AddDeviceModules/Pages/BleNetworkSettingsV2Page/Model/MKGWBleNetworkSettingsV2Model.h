//
//  MKGWBleNetworkSettingsV2Model.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/15.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBleNetworkSettingsV2Model : NSObject

/// 0:ethernet   1:wifi 2:ETH->WIFI 3:WIFI->ETH
@property (nonatomic, assign)NSInteger networkType;

#pragma mark - Wifi Settings

/// 0:personal  1:enterprise
@property (nonatomic, assign)NSInteger security;

/// security为enterprise的时候才有效。0:PEAP-MSCHAPV2  1:TTLS-MSCHAPV2  2:TLS
@property (nonatomic, assign)NSInteger eapType;

/// 1-32 Characters.
@property (nonatomic, copy)NSString *ssid;

/// 0-64 Characters.security为personal的时候才有效
@property (nonatomic, copy)NSString *wifiPassword;

/// 0-32 Characters.  eapType为PEAP-MSCHAPV2/TTLS-MSCHAPV2才有效
@property (nonatomic, copy)NSString *eapUserName;

/// 0-64 Characters.eapType为TLS的时候无此参数
@property (nonatomic, copy)NSString *eapPassword;

/// 0-64 Characters.eapType为TLS的时候有效
@property (nonatomic, copy)NSString *domainID;

/// eapType为PEAP-MSCHAPV2/TTLS-MSCHAPV2才有效
@property (nonatomic, assign)BOOL verifyServer;

/// security为personal无此参数
@property (nonatomic, copy)NSString *caFileName;

/// eapType为TLS有效
@property (nonatomic, copy)NSString *clientKeyName;

/// eapType为TLS有效
@property (nonatomic, copy)NSString *clientCertName;

#pragma mark - Ethernet Network Settings

@property (nonatomic, assign)BOOL ethernet_dhcp;

@property (nonatomic, copy)NSString *ethernet_ip;

@property (nonatomic, copy)NSString *ethernet_mask;

@property (nonatomic, copy)NSString *ethernet_gateway;

@property (nonatomic, copy)NSString *ethernet_dns;

#pragma mark - Wifi Network Settings

@property (nonatomic, assign)BOOL wifi_dhcp;

@property (nonatomic, copy)NSString *wifi_ip;

@property (nonatomic, copy)NSString *wifi_mask;

@property (nonatomic, copy)NSString *wifi_gateway;

@property (nonatomic, copy)NSString *wifi_dns;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
