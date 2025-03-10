//
//  MKGWNetworkSsidSettingsCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2024/9/1.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWNetworkSsidSettingsCellModel : NSObject

@property (nonatomic, copy)NSString *ssid;

@end

@protocol MKGWNetworkSsidSettingsCellDelegate <NSObject>

- (void)gw_networkSsidSettingsCell_ssidChanged:(NSString *)ssid;

- (void)gw_networkSsidSettingsCell_buttonPressed;

@end

@interface MKGWNetworkSsidSettingsCell : MKBaseCell

@property (nonatomic, strong)MKGWNetworkSsidSettingsCellModel *dataModel;

@property (nonatomic, weak)id <MKGWNetworkSsidSettingsCellDelegate>delegate;

+ (MKGWNetworkSsidSettingsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
