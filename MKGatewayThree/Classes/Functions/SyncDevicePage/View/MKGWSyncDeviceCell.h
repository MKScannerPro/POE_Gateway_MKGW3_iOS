//
//  MKGWSyncDeviceCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/3/7.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

#import "MKGWDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWSyncDeviceCellModel : MKGWDeviceModel

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKGWSyncDeviceCellDelegate <NSObject>

- (void)gw_syncDeviceCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKGWSyncDeviceCell : MKBaseCell

@property (nonatomic, strong)MKGWSyncDeviceCellModel *dataModel;

@property (nonatomic, weak)id <MKGWSyncDeviceCellDelegate>delegate;

+ (MKGWSyncDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
