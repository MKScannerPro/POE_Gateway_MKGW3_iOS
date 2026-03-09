//
//  MKScannerSystemTimeCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKScannerSystemTimeCellDelegate <NSObject>

- (void)mk_scanner_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKScannerSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKScannerSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKScannerSystemTimeCellDelegate>delegate;

+ (MKScannerSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
