//
//  MKScannerNormalConnectedCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerNormalConnectedCellModel : NSObject

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

@protocol MKScannerNormalConnectedCellDelegate <NSObject>

- (void)mk_scanner_normalConnectedCell_writeButtonPressed:(NSInteger)section
                                                      row:(NSInteger)row
                                               serverUUID:(NSString *)serverUUID
                                           characteristic:(NSString *)characteristic;

- (void)mk_scanner_normalConnectedCell_readButtonPressed:(NSInteger)section
                                                     row:(NSInteger)row
                                              serverUUID:(NSString *)serverUUID
                                          characteristic:(NSString *)characteristic;

- (void)mk_scanner_normalConnectedCell_notifyButtonPressed:(BOOL)notify
                                                   section:(NSInteger)section
                                                       row:(NSInteger)row
                                                serverUUID:(NSString *)serverUUID
                                            characteristic:(NSString *)characteristic;

@end

@interface MKScannerNormalConnectedCell : MKBaseCell

@property (nonatomic, weak)id <MKScannerNormalConnectedCellDelegate>delegate;

@property (nonatomic, strong)MKScannerNormalConnectedCellModel *dataModel;

+ (MKScannerNormalConnectedCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
