//
//  MKGWSystemTimeCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKGWSystemTimeCellDelegate <NSObject>

- (void)gw_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKGWSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKGWSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKGWSystemTimeCellDelegate>delegate;

+ (MKGWSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
