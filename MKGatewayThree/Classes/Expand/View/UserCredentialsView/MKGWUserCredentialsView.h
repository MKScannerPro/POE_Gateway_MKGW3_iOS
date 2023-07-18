//
//  MKGWUserCredentialsView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKGWUserCredentialsViewDelegate <NSObject>

- (void)gw_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)gw_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKGWUserCredentialsView : UIView

@property (nonatomic, strong)MKGWUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKGWUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
