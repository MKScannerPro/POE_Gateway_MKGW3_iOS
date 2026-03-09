//
//  MKScannerManageBleDevicesSearchButton.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerManageBleDevicesSearchButtonModel : NSObject

/// 显示的标题
@property (nonatomic, copy)NSString *placeholder;

/// 显示的搜索名字
@property (nonatomic, copy)NSString *searchName;

/// 显示的搜索mac地址
@property (nonatomic, copy)NSString *searchMac;

/// 过滤的RSSI值
@property (nonatomic, assign)NSInteger searchRssi;

/// 过滤的最小RSSI值，当searchRssi == minSearchRssi时，不显示searchRssi搜索条件
@property (nonatomic, assign)NSInteger minSearchRssi;

@end

@protocol MKScannerManageBleDevicesSearchButtonDelegate <NSObject>

/// 搜索按钮点击事件
- (void)mk_scanner_scanSearchButtonMethod;

/// 搜索按钮右侧清除按钮点击事件
- (void)mk_scanner_scanSearchButtonClearMethod;

@end

@interface MKScannerManageBleDevicesSearchButton : UIControl

@property (nonatomic, strong)MKScannerManageBleDevicesSearchButtonModel *dataModel;

@property (nonatomic, weak)id <MKScannerManageBleDevicesSearchButtonDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
