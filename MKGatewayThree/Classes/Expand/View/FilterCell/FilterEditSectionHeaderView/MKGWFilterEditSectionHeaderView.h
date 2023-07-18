//
//  MKGWFilterEditSectionHeaderView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/6..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterEditSectionHeaderViewModel : NSObject

/// sectionHeader所在index
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, strong)UIColor *contentColor;

@end

@protocol MKGWFilterEditSectionHeaderViewDelegate <NSObject>

/// 加号点击事件
/// @param index 所在index
- (void)mk_gw_filterEditSectionHeaderView_addButtonPressed:(NSInteger)index;

/// 减号点击事件
/// @param index 所在index
- (void)mk_gw_filterEditSectionHeaderView_subButtonPressed:(NSInteger)index;

@end

@interface MKGWFilterEditSectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)MKGWFilterEditSectionHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKGWFilterEditSectionHeaderViewDelegate>delegate;

+ (MKGWFilterEditSectionHeaderView *)initHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
