//
//  MKScannerFilterCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/9.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerFilterCellModel : NSObject

/// cell标识符
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger dataListIndex;

@property (nonatomic, strong)NSArray <NSString *>*dataList;

@end

@protocol MKScannerFilterCellDelegate <NSObject>

- (void)mk_scanner_filterValueChanged:(NSInteger)dataListIndex index:(NSInteger)index;

@end

@interface MKScannerFilterCell : MKBaseCell

@property (nonatomic, strong)MKScannerFilterCellModel *dataModel;

@property (nonatomic, weak)id <MKScannerFilterCellDelegate>delegate;

+ (MKScannerFilterCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
