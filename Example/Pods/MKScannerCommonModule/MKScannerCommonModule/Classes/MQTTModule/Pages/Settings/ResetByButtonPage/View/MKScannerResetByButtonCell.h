//
//  MKScannerResetByButtonCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerResetByButtonCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKScannerResetByButtonCellDelegate <NSObject>

- (void)mk_scanner_resetByButtonCellAction:(NSInteger)index;

@end

@interface MKScannerResetByButtonCell : MKBaseCell

@property (nonatomic, weak)id <MKScannerResetByButtonCellDelegate>delegate;

@property (nonatomic, strong)MKScannerResetByButtonCellModel *dataModel;

+ (MKScannerResetByButtonCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
