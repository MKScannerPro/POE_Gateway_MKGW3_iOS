//
//  MKScannerPressEventCountCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerPressEventCountCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *count;

@end

@protocol MKScannerPressEventCountCellDelegate <NSObject>

- (void)mk_scanner_pressEventCountCell_clearButtonPressed:(NSInteger)index;

@end

@interface MKScannerPressEventCountCell : MKBaseCell

@property (nonatomic, weak)id <MKScannerPressEventCountCellDelegate>delegate;

@property (nonatomic, strong)MKScannerPressEventCountCellModel *dataModel;

+ (MKScannerPressEventCountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
