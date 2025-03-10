//
//  MKGWNearbyWifiCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2024/9/5.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWNearbyWifiCellModel : NSObject

@property (nonatomic, copy)NSString *ssid;

@property (nonatomic, copy)NSString *bssid;

@property (nonatomic, strong)NSNumber *rssi;

@end

@interface MKGWNearbyWifiCell : MKBaseCell

@property (nonatomic, strong)MKGWNearbyWifiCellModel *dataModel;

+ (MKGWNearbyWifiCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
