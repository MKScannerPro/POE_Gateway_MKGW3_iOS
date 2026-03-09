//
//  MKScannerConnectedDeviceWriteAlertView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerConnectedDeviceWriteAlertView : UIView

- (void)showAlertWithValue:(NSString *)value
               dismissNote:(NSString *)dismissNote
              cancelAction:(void (^)(void))cancelAction
             confirmAction:(void (^)(NSString *textValue))confirmAction;

@end

NS_ASSUME_NONNULL_END
