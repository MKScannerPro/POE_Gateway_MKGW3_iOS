//
//  MKScannerMQTTSSLForAppView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerMQTTSSLForAppViewModel : NSObject

@property (nonatomic, assign)BOOL sslIsOn;

/// 0:CA certificate     1:Self signed certificates
@property (nonatomic, assign)NSInteger certificate;

@property (nonatomic, copy)NSString *caFileName;

/// P12证书
@property (nonatomic, copy)NSString *clientFileName;

@end

@protocol MKScannerMQTTSSLForAppViewDelegate <NSObject>

- (void)mk_scanner_mqtt_sslParams_app_sslStatusChanged:(BOOL)isOn;

/// 用户选择了加密方式
/// @param certificate 0:CA certificate     1:Self signed certificates
- (void)mk_scanner_mqtt_sslParams_app_certificateChanged:(NSInteger)certificate;

/// 用户点击选择了caFaile按钮
- (void)mk_scanner_mqtt_sslParams_app_caFilePressed;

/// 用户点击选择了P12证书按钮
- (void)mk_scanner_mqtt_sslParams_app_clientFilePressed;

@end

@interface MKScannerMQTTSSLForAppView : UIView

@property (nonatomic, strong)MKScannerMQTTSSLForAppViewModel *dataModel;

@property (nonatomic, weak)id <MKScannerMQTTSSLForAppViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
