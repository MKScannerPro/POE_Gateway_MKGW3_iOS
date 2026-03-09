//
//  MKScannerBleServerConfigDeviceSettingView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBleServerConfigDeviceSettingViewDelegate <NSObject>

/// 底部按钮
/// @param index 0:Export Demo File   1:Import Config File  2:Clear All Configurations
- (void)mk_scanner_mqtt_deviecSetting_fileButtonPressed:(NSInteger)index;

@end

@interface MKScannerBleServerConfigDeviceSettingView : UIView

@property (nonatomic, weak)id <MKScannerBleServerConfigDeviceSettingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
