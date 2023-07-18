//
//  MKGWDeviceDataPageHeaderView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDeviceDataPageHeaderViewModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@end

@protocol MKGWDeviceDataPageHeaderViewDelegate <NSObject>

- (void)gw_updateLoadButtonAction;

- (void)gw_scannerStatusChanged:(BOOL)isOn;

- (void)gw_manageBleDeviceAction;

- (void)gw_filterTestButtonAction;

@end

@interface MKGWDeviceDataPageHeaderView : UIView

@property (nonatomic, strong)MKGWDeviceDataPageHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKGWDeviceDataPageHeaderViewDelegate>delegate;

- (void)updateTotalNumbers:(NSInteger)numbers;

@end

NS_ASSUME_NONNULL_END
