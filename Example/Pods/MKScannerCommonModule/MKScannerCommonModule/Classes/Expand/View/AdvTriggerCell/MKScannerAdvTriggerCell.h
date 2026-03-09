//
//  MKScannerAdvTriggerCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerAdvTriggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *advInterval;

/*
 对于deviceType=23的C112设备，最高支持到0dBm，其余可以支持到+6dBm
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:3dBm
 8:4dBm
 */
@property (nonatomic, assign)NSInteger txPower;

@end

@protocol MKScannerAdvTriggerCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: ADV after triggered
///   - txPower: 当前Tx Power
/*
 0:-40dBm
 1:-20dBm
 2:-16dBm
 3:-12dBm
 4:-8dBm
 5:-4dBm
 6:0dBm
 7:3dBm
 8:4dBm
 */
- (void)mk_scanner_advTriggerCell_setPressed:(NSInteger)index
                                    interval:(NSString *)interval
                                     txPower:(NSInteger)txPower;

@end

@interface MKScannerAdvTriggerCell : MKBaseCell

@property (nonatomic, weak)id <MKScannerAdvTriggerCellDelegate>delegate;

@property (nonatomic, strong)MKScannerAdvTriggerCellModel *dataModel;

+ (MKScannerAdvTriggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
