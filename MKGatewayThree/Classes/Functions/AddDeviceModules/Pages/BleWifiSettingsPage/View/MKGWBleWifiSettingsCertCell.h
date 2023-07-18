//
//  MKGWBleWifiSettingsCertCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/30.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBleWifiSettingsCertCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKGWBleWifiSettingsCertCellDelegate <NSObject>

- (void)gw_bleWifiSettingsCertPressed:(NSInteger)index;

@end

@interface MKGWBleWifiSettingsCertCell : MKBaseCell

@property (nonatomic, strong)MKGWBleWifiSettingsCertCellModel *dataModel;

@property (nonatomic, weak)id <MKGWBleWifiSettingsCertCellDelegate>delegate;

+ (MKGWBleWifiSettingsCertCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
