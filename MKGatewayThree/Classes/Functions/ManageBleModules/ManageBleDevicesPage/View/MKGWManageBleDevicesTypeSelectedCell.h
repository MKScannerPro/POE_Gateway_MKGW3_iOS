//
//  MKGWManageBleDevicesTypeSelectedCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWManageBleDevicesTypeSelectedCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKGWManageBleDevicesTypeSelectedCellDelegate <NSObject>

- (void)gw_manageBleDevicesTypeSelectedCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKGWManageBleDevicesTypeSelectedCell : UITableViewCell

@property (nonatomic, weak)id <MKGWManageBleDevicesTypeSelectedCellDelegate>delegate;

@property (nonatomic, strong)MKGWManageBleDevicesTypeSelectedCellModel *dataModel;

+ (MKGWManageBleDevicesTypeSelectedCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
