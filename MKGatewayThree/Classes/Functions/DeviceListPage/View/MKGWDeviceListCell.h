//
//  MKGWDeviceListCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWDeviceListCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)gw_cellDeleteButtonPressed:(NSInteger)index;

@end

@class MKGWDeviceListModel;
@interface MKGWDeviceListCell : MKBaseCell

@property (nonatomic, weak)id <MKGWDeviceListCellDelegate>delegate;

@property (nonatomic, strong)MKGWDeviceListModel *dataModel;

+ (MKGWDeviceListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
