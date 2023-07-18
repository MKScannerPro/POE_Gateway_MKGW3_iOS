//
//  MKGWFilterBeaconCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterBeaconCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *minValue;

@property (nonatomic, copy)NSString *maxValue;

@end

@protocol MKGWFilterBeaconCellDelegate <NSObject>

- (void)mk_gw_beaconMinValueChanged:(NSString *)value index:(NSInteger)index;

- (void)mk_gw_beaconMaxValueChanged:(NSString *)value index:(NSInteger)index;

@end

@interface MKGWFilterBeaconCell : MKBaseCell

@property (nonatomic, strong)MKGWFilterBeaconCellModel *dataModel;

@property (nonatomic, weak)id <MKGWFilterBeaconCellDelegate>delegate;

+ (MKGWFilterBeaconCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
