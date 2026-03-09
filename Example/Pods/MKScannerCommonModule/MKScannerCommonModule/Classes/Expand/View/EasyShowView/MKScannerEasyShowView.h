//
//  MKScannerEasyShowView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/25.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerEasyShowView : UIView

- (void)showText:(NSString *)text
       superView:(UIView *)superView
        animated:(BOOL)animated;

- (void)hidden;

@end

NS_ASSUME_NONNULL_END
