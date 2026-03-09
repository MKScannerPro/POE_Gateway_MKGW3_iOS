//
//  MKScannerButtonFirmwareCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerButtonFirmwareCellModel : NSObject

/// cell唯一识别号
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

@property (nonatomic, copy)NSString *rightButtonTitle;

@end

@protocol MKScannerButtonFirmwareCellDelegate <NSObject>

- (void)mk_scanner_buttonFirmwareCell_buttonAction:(NSInteger)index;

@end

@interface MKScannerButtonFirmwareCell : MKBaseCell

@property (nonatomic, strong)MKScannerButtonFirmwareCellModel *dataModel;

@property (nonatomic, weak)id <MKScannerButtonFirmwareCellDelegate>delegate;

+ (MKScannerButtonFirmwareCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
