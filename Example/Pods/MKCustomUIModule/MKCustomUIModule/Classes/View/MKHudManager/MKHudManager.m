//
//  MKHudManager.m
//  FitPolo
//
//  Created by aa on 17/5/8.
//  Copyright © 2017年 MK. All rights reserved.
//

#import "MKHudManager.h"
#import "JGProgressHUD.h"
#import "MKMacroDefines.h"

@interface MKHudManager ()

@property (nonatomic, strong)UIView *inView;

@property (nonatomic, strong)JGProgressHUD *progressHUD;

@end

@implementation MKHudManager

+ (instancetype)share {
    static dispatch_once_t t;
    static MKHudManager *manager = nil;
    dispatch_once(&t, ^{
        manager = [[MKHudManager alloc] init];
    });
    return manager;
}

- (void)showHUDWithTitle:(NSString *)title
                  inView:(UIView *)inView
           isPenetration:(BOOL)isPenetration {
    if (_progressHUD) {
        [self hide];
        _progressHUD = nil;
    }
    
    _inView = inView;
    UIView *baseView = inView ?: kAppWindow;
    
    _progressHUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    _progressHUD.interactionType = isPenetration ? JGProgressHUDInteractionTypeBlockNoTouches : JGProgressHUDInteractionTypeBlockAllTouches;
    _progressHUD.square = NO;
    _progressHUD.cornerRadius = 5.0;
    _progressHUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    
    _progressHUD.textLabel.text = title;
    
    [_progressHUD showInView:baseView];
}

- (void)showHUDWithTitle:(NSString *)title inView:(UIView *)inView {
    [self showHUDWithTitle:title inView:inView isPenetration:NO];
}

- (void)show {
    if (_inView) {
        [_progressHUD showInView:_inView];
    } else {
        [_progressHUD showInView:kAppWindow];
    }
}

- (void)hide {
    if (_inView) {
        _inView.userInteractionEnabled = YES;
    }
    moko_dispatch_main_safe(^{
        [_progressHUD dismiss];
    });
}

- (void)hideAfterDelay:(NSTimeInterval)delay {
    [_progressHUD dismissAfterDelay:delay];
}

@end
