//
//  MKGWFilterTestAlert.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/6/26.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterTestAlert : UIView

- (void)showWithHandler:(void (^)(NSString *duration))handler;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
