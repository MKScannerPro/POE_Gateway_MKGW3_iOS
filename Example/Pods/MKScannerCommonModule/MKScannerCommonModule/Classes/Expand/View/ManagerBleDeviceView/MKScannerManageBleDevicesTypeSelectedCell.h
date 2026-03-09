//
//  MKScannerManageBleDevicesTypeSelectedCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerManageBleDevicesTypeSelectedCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKScannerManageBleDevicesTypeSelectedCellDelegate <NSObject>

- (void)mk_scanner_manageBleDevicesTypeSelectedCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKScannerManageBleDevicesTypeSelectedCell : UITableViewCell

@property (nonatomic, weak)id <MKScannerManageBleDevicesTypeSelectedCellDelegate>delegate;

@property (nonatomic, strong)MKScannerManageBleDevicesTypeSelectedCellModel *dataModel;

+ (MKScannerManageBleDevicesTypeSelectedCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
