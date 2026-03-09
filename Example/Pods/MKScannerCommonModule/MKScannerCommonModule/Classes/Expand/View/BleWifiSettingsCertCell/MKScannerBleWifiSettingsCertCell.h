//
//  MKScannerBleWifiSettingsCertCell.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerBleWifiSettingsCertCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKScannerBleWifiSettingsCertCellDelegate <NSObject>

- (void)mk_scanner_bleWifiSettingsCertPressed:(NSInteger)index;

@end

@interface MKScannerBleWifiSettingsCertCell : MKBaseCell

@property (nonatomic, strong)MKScannerBleWifiSettingsCertCellModel *dataModel;

@property (nonatomic, weak)id <MKScannerBleWifiSettingsCertCellDelegate>delegate;

+ (MKScannerBleWifiSettingsCertCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
