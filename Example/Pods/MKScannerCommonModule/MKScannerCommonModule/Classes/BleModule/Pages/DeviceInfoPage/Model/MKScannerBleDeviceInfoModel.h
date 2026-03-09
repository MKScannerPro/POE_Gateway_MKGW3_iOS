//
//  MKScannerBleDeviceInfoModel.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleDeviceInfoModel : NSObject

/// 要展示的左侧msg，表示当前数值是什么
@property (nonatomic, copy)NSString *key;

/// 要展示的右侧信息，表示数值
@property (nonatomic, copy)NSString *value;

@end

NS_ASSUME_NONNULL_END
