//
//  MKGWAdvTriggerTwoStateCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/21.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWAdvTriggerTwoStateCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *beforeTriggerInterval;

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
@property (nonatomic, assign)NSInteger beforeTriggerTxPower;

@property (nonatomic, copy)NSString *afterTriggerInterval;

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
@property (nonatomic, assign)NSInteger afterTriggerTxPower;

@end

@protocol MKGWAdvTriggerTwoStateCellDelegate <NSObject>

/// set按钮点击事件
/// - Parameters:
///   - index: index
///   - beforeInterval: ADV before triggered ADV interval
///   - beforeTxPower: ADV before triggered Tx Power
///   - afterInterval: ADV after triggered ADV interval
///   - afterTxPower: ADV after triggered Tx Power
/*
 -40
 -20
 -16
 -12
 -8
 -4
 0
 3
 4
 */
- (void)gw_advNormalCell_setPressed:(NSInteger)index
                     beforeInterval:(NSString *)beforeInterval
                      beforeTxPower:(NSInteger)beforeTxPower
                      afterInterval:(NSString *)afterInterval
                       afterTxPower:(NSInteger)afterTxPower;

@end

@interface MKGWAdvTriggerTwoStateCell : MKBaseCell

@property (nonatomic, weak)id <MKGWAdvTriggerTwoStateCellDelegate>delegate;

@property (nonatomic, strong)MKGWAdvTriggerTwoStateCellModel *dataModel;

+ (MKGWAdvTriggerTwoStateCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
