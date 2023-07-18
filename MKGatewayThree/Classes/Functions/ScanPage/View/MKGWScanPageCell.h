//
//  MKGWScanPageCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKGWScanPageModel;
@interface MKGWScanPageCell : MKBaseCell

@property (nonatomic, strong)MKGWScanPageModel *dataModel;

+ (MKGWScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
