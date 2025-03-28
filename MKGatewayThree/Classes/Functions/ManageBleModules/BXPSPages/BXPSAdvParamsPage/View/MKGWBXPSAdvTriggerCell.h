//
//  MKGWBXPSAdvTriggerCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGWBXPSAdvTriggerCellSlotType) {
    MKGWBXPSAdvTriggerCellSlotTypeUID,
    MKGWBXPSAdvTriggerCellSlotTypeURL,
    MKGWBXPSAdvTriggerCellSlotTypeTLM,
    MKGWBXPSAdvTriggerCellSlotTypeBeacon,
    MKGWBXPSAdvTriggerCellSlotTypeTHInfo,
    MKGWBXPSAdvTriggerCellSlotTypeSensorInfo,
    MKGWBXPSAdvTriggerCellSlotTypeNoData,
};

@interface MKGWBXPSAdvTriggerCellModel : NSObject

@property (nonatomic, assign)NSInteger slotIndex;

@property (nonatomic, assign)MKGWBXPSAdvTriggerCellSlotType slotType;

@property (nonatomic, copy)NSString *advInterval;

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
@property (nonatomic, assign)NSInteger txPower;

- (CGFloat)fetchCellHeight;

@end

@protocol MKGWBXPSAdvTriggerCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - interval: 当前ADV interval
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
- (void)gw_BXPSAdvTriggerCell_setPressed:(NSInteger)index
                                interval:(NSString *)interval
                                 txPower:(NSInteger)txPower;

@end

@interface MKGWBXPSAdvTriggerCell : MKBaseCell

@property (nonatomic, weak)id <MKGWBXPSAdvTriggerCellDelegate>delegate;

@property (nonatomic, strong)MKGWBXPSAdvTriggerCellModel *dataModel;

+ (MKGWBXPSAdvTriggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
