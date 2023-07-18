//
//  MKGWResetByButtonCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWResetByButtonCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKGWResetByButtonCellDelegate <NSObject>

- (void)gw_resetByButtonCellAction:(NSInteger)index;

@end

@interface MKGWResetByButtonCell : MKBaseCell

@property (nonatomic, weak)id <MKGWResetByButtonCellDelegate>delegate;

@property (nonatomic, strong)MKGWResetByButtonCellModel *dataModel;

+ (MKGWResetByButtonCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
