//
//  MKGWButtonFirmwareCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWButtonFirmwareCellModel : NSObject

/// cell唯一识别号
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

@property (nonatomic, copy)NSString *rightButtonTitle;

@end

@protocol MKGWButtonFirmwareCellDelegate <NSObject>

- (void)gw_buttonFirmwareCell_buttonAction:(NSInteger)index;

@end

@interface MKGWButtonFirmwareCell : MKBaseCell

@property (nonatomic, strong)MKGWButtonFirmwareCellModel *dataModel;

@property (nonatomic, weak)id <MKGWButtonFirmwareCellDelegate>delegate;

+ (MKGWButtonFirmwareCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
