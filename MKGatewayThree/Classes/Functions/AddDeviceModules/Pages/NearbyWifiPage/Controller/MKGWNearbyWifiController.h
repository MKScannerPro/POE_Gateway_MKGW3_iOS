//
//  MKGWNearbyWifiController.h
//  MKGatewayThree_Example
//
//  Created by aa on 2024/9/5.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWNearbyWifiControllerDelegate <NSObject>

- (void)gw_nearbyWifiController_selectedWifi:(NSString *)ssid;

@end

@interface MKGWNearbyWifiController : MKBaseViewController

@property (nonatomic, weak)id <MKGWNearbyWifiControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
