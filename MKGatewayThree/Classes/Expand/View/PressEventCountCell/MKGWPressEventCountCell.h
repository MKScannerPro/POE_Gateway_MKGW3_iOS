//
//  MKGWPressEventCountCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/19.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWPressEventCountCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *count;

@end

@protocol MKGWPressEventCountCellDelegate <NSObject>

- (void)gw_pressEventCountCell_clearButtonPressed:(NSInteger)index;

@end

@interface MKGWPressEventCountCell : MKBaseCell

@property (nonatomic, weak)id <MKGWPressEventCountCellDelegate>delegate;

@property (nonatomic, strong)MKGWPressEventCountCellModel *dataModel;

+ (MKGWPressEventCountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
