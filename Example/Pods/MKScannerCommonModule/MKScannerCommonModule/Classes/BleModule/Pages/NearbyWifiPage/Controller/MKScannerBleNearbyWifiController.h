//
//  MKScannerBleNearbyWifiController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleBaseController.h"

#import "MKScannerBleNearbyWifiProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBleNearbyWifiControllerDelegate <NSObject>

- (void)mk_scanner_nearbyWifiController_selectedWifi:(NSString *)ssid;

@end

@interface MKScannerBleNearbyWifiController : MKScannerBleBaseController

@property (nonatomic, weak)id <MKScannerBleNearbyWifiControllerDelegate>delegate;

- (instancetype)initWithProtocol:(id<MKScannerBleNearbyWifiProtocol>)protocol;

@end

NS_ASSUME_NONNULL_END
