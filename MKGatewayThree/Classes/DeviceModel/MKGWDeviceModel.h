//
//  MKGWDeviceModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/1/29.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import "MKScannerCommonModule/MKScannerDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDeviceModel : MKScannerDeviceModel

/// 0:ethernet   1:wifi 2:ETH->WIFI 3:WIFI->ETH
@property (nonatomic, copy)NSString *networkType;

/**
 当前model的订阅主题，当用户设置了app的订阅主题时，返回设置的订阅主题，否则返回当前model的订阅主题
 
 @return subscribedTopic
 */
- (NSString *)currentSubscribedTopic;

/**
 当前model的发布主题，当用户设置了app的发布主题时，返回设置的发布主题，否则返回当前model的发布主题
 
 @return publishedTopic
 */
- (NSString *)currentPublishedTopic;

@end

NS_ASSUME_NONNULL_END
