//
//  MKGWFilterCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/6.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKGWFilterCellDelegate <NSObject>

- (void)gw_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKGWFilterCell : MKBaseCell

@property (nonatomic, strong)MKGWFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKGWFilterCellDelegate>delegate;

+ (MKGWFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
