//
//  MKScannerBXPSAdvNormalCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/2.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKScannerBXPSAdvNormalCellSlotType) {
    MKScannerBXPSAdvNormalCellSlotTypeUID,
    MKScannerBXPSAdvNormalCellSlotTypeURL,
    MKScannerBXPSAdvNormalCellSlotTypeTLM,
    MKScannerBXPSAdvNormalCellSlotTypeBeacon,
    MKScannerBXPSAdvNormalCellSlotTypeTHInfo,
    MKScannerBXPSAdvNormalCellSlotTypeSensorInfo,
    MKScannerBXPSAdvNormalCellSlotTypeNoData,
};

@interface MKScannerBXPSAdvNormalCellModel : NSObject

@property (nonatomic, assign)NSInteger slotIndex;

@property (nonatomic, assign)MKScannerBXPSAdvNormalCellSlotType slotType;

@property (nonatomic, copy)NSString *advInterval;

/*
 0:-20dBm
 1:-16dBm
 2:-12dBm
 3:-8dBm
 4:-4dBm
 5:0dBm
 6:3dBm
 7:4dBm
 8:6dBm
 */
@property (nonatomic, assign)NSInteger txPower;

- (CGFloat)fetchCellHeight;

@end

@protocol MKScannerBXPSAdvNormalCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: 当前ADV interval
///   - txPower: 当前Tx Power
/*
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 6
 */
- (void)mk_scanner_BXPSAdvNormalCell_setPressed:(NSInteger)index
                                       interval:(NSString *)interval
                                        txPower:(NSInteger)txPower;

@end

@interface MKScannerBXPSAdvNormalCell : MKBaseCell

@property (nonatomic, weak)id <MKScannerBXPSAdvNormalCellDelegate>delegate;

@property (nonatomic, strong)MKScannerBXPSAdvNormalCellModel *dataModel;

+ (MKScannerBXPSAdvNormalCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
