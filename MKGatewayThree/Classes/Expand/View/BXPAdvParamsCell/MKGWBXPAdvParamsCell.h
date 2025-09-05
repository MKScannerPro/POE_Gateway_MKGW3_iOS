//
//  MKGWBXPAdvParamsCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/2/8.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGWBXPAdvParamsCellSlotType) {
    MKGWBXPAdvParamsCellSlotTypeUID,
    MKGWBXPAdvParamsCellSlotTypeURL,
    MKGWBXPAdvParamsCellSlotTypeTLM,
    MKGWBXPAdvParamsCellSlotTypeEID,
    MKGWBXPAdvParamsCellSlotTypeDeviceInfo,
    MKGWBXPAdvParamsCellSlotTypeiBeacon,
    MKGWBXPAdvParamsCellSlotTypeAccelerometer,
    MKGWBXPAdvParamsCellSlotTypeHT,
    MKGWBXPAdvParamsCellSlotTypeTag,
    MKGWBXPAdvParamsCellSlotTypeNoData,
};

typedef NS_ENUM(NSInteger, MKGWBXPAdvParamsCellTriggerType) {
    MKGWBXPAdvParamsCellTriggerTypeNull,
    MKGWBXPAdvParamsCellTriggerTypeTemperature,
    MKGWBXPAdvParamsCellTriggerTypeHumidity,
    MKGWBXPAdvParamsCellTriggerTypeDoubleClick,
    MKGWBXPAdvParamsCellTriggerTypeTripleClick,
    MKGWBXPAdvParamsCellTriggerTypeMove,
    MKGWBXPAdvParamsCellTriggerTypeLight,
    MKGWBXPAdvParamsCellTriggerTypeSingleClick
};

@interface MKGWBXPAdvParamsCellModel : NSObject

@property (nonatomic, assign)NSInteger slotIndex;

/// 通道类型，
@property (nonatomic, assign)MKGWBXPAdvParamsCellSlotType slotType;

@property (nonatomic, assign)MKGWBXPAdvParamsCellTriggerType triggerType;

@property (nonatomic, copy)NSString *interval;

/// 对于BXP-Tag设备来说，txPower最大到6dBm
@property (nonatomic, assign)BOOL bxpTag;

/*
 对于非BXP-Tag
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
/*
 对于BXP-Tag
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

@protocol MKGWBXPAdvParamsCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - slotIndex: slotIndex
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
- (void)gw_BXPAdvParamsCell_setPressedWithSlotIndex:(NSInteger)slotIndex
                                           interval:(NSString *)interval
                                            txPower:(NSInteger)txPower;

@end

@interface MKGWBXPAdvParamsCell : MKBaseCell

@property (nonatomic, weak)id <MKGWBXPAdvParamsCellDelegate>delegate;

@property (nonatomic, strong)MKGWBXPAdvParamsCellModel *dataModel;

+ (MKGWBXPAdvParamsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
