//
//  MKScannerBleNearbyWifiCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleNearbyWifiCellModel : NSObject

@property (nonatomic, copy)NSString *ssid;

@property (nonatomic, copy)NSString *bssid;

@property (nonatomic, strong)NSNumber *rssi;

@end

@interface MKScannerBleNearbyWifiCell : MKBaseCell

@property (nonatomic, strong)MKScannerBleNearbyWifiCellModel *dataModel;

+ (MKScannerBleNearbyWifiCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
