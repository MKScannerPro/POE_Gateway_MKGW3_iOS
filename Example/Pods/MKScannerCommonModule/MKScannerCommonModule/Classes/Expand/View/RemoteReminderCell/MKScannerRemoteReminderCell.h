//
//  MKScannerRemoteReminderCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerRemoteReminderCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKScannerRemoteReminderCellDelegate <NSObject>

- (void)mk_scanner_remindButtonPressed:(NSInteger)index;

@end

@interface MKScannerRemoteReminderCell : MKBaseCell

@property (nonatomic, strong)MKScannerRemoteReminderCellModel *dataModel;

@property (nonatomic, weak)id <MKScannerRemoteReminderCellDelegate>delegate;

+ (MKScannerRemoteReminderCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
