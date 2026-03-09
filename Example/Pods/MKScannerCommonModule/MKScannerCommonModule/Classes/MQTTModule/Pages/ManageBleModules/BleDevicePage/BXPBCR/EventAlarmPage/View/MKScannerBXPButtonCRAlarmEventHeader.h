//
//  MKScannerBXPButtonCRAlarmEventHeader.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerBXPButtonCRAlarmEventHeaderDelegate <NSObject>

- (void)mk_scanner_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)mk_scanner_bxpButtonCRAlarmEventHeaderView_exportButtonPressed;

@end

@interface MKScannerBXPButtonCRAlarmEventHeader : UIView

@property (nonatomic, weak)id <MKScannerBXPButtonCRAlarmEventHeaderDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
