//
//  MKScannerUserCredentialsView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/27.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKScannerUserCredentialsViewDelegate <NSObject>

- (void)mk_scanner_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)mk_scanner_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKScannerUserCredentialsView : UIView

@property (nonatomic, strong)MKScannerUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKScannerUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
