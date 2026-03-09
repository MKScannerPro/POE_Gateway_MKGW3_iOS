//
//  MKScannerHistoricalTHDataHeaderView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)mk_scanner_historicalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)mk_scanner_historicalHTDataHeaderView_deleteButtonPressed;

- (void)mk_scanner_historicalHTDataHeaderView_exportButtonPressed;

@end

@interface MKScannerHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKScannerHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
