//
//  MKGWNormalConnectedCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/8.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWNormalConnectedCellModel : NSObject

@property (nonatomic, assign)NSInteger section;

@property (nonatomic, assign)NSInteger row;

@property (nonatomic, copy)NSString *server;

@property (nonatomic, copy)NSString *characteristic;

/*
 Bit0:BOARFCAST
 Bit1:READ
 Bit2:WRITE_NR
 Bit3:WRITE
 Bit4:NOTIFY
 Bit5:INDICATE
 Bit6:AUTH
 Bit7:EXT_PROP
 */
@property (nonatomic, copy)NSString *properties;

/*
 -1表示特征不支持通知
 0表示特征通知关闭
 1表示特征通知打开
 */
@property (nonatomic, assign)NSInteger notifyStatus;

@property (nonatomic, copy)NSString *value;

- (CGFloat)cellHeightWithWidth:(CGFloat)viewWidth;

@end

@protocol MKGWNormalConnectedCellDelegate <NSObject>

- (void)gw_normalConnectedCell_writeButtonPressed:(NSInteger)section
                                              row:(NSInteger)row
                                       serverUUID:(NSString *)serverUUID
                                   characteristic:(NSString *)characteristic;

- (void)gw_normalConnectedCell_readButtonPressed:(NSInteger)section
                                             row:(NSInteger)row
                                      serverUUID:(NSString *)serverUUID
                                  characteristic:(NSString *)characteristic;

- (void)gw_normalConnectedCell_notifyButtonPressed:(BOOL)notify
                                           section:(NSInteger)section
                                               row:(NSInteger)row
                                        serverUUID:(NSString *)serverUUID
                                    characteristic:(NSString *)characteristic;

@end

@interface MKGWNormalConnectedCell : MKBaseCell

@property (nonatomic, weak)id <MKGWNormalConnectedCellDelegate>delegate;

@property (nonatomic, strong)MKGWNormalConnectedCellModel *dataModel;

+ (MKGWNormalConnectedCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
