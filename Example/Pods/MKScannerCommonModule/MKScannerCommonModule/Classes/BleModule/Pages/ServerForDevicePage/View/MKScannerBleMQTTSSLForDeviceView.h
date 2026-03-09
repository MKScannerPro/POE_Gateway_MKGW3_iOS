//
//  MKScannerBleMQTTSSLForDeviceView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleMQTTSSLForDeviceViewModel : NSObject

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

@property (nonatomic, copy)NSString *clientKeyName;

@property (nonatomic, copy)NSString *clientCertName;

@end

@protocol MKScannerBleMQTTSSLForDeviceViewDelegate <NSObject>

- (void)mk_scanner_mqtt_sslParams_device_sslStatusChanged:(BOOL)isOn;

/// 用户选择了加密方式
/// @param certificate 0:CA signed server certificate     1:CA certificate     2:Self signed certificates
- (void)mk_scanner_mqtt_sslParams_device_certificateChanged:(NSInteger)certificate;

/// 用户点击选择了caFaile按钮
- (void)mk_scanner_mqtt_sslParams_device_caFilePressed;

/// 用户点击选择了Client Key按钮
- (void)mk_scanner_mqtt_sslParams_device_clientKeyPressed;

/// 用户点击了Client Cert File按钮
- (void)mk_scanner_mqtt_sslParams_device_clientCertPressed;

@end

@interface MKScannerBleMQTTSSLForDeviceView : UIView

@property (nonatomic, strong)MKScannerBleMQTTSSLForDeviceViewModel *dataModel;

@property (nonatomic, weak)id <MKScannerBleMQTTSSLForDeviceViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
