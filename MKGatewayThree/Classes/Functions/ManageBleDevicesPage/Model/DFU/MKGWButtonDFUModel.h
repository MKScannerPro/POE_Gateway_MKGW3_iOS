//
//  MKGWButtonDFUModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerButtonDfuV1Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWButtonDFUModel : NSObject<MKScannerButtonDfuV1Protocol>

/// dfu升级百分比，gatewayMacAddress当前网关设备的mac，deviceMacAddress当前网关连接的设备的mac，percent当前百分比
@property (nonatomic, copy)void (^receiveDfuProgressBlock)(NSString *gatewayMacAddress, NSString *deviceMacAddress, NSString *percent);

/// dfu升级完成，gatewayMacAddress当前网关设备的mac，deviceMacAddress当前网关连接的设备的mac, resultCode=0表明升级成功
@property (nonatomic, copy)void (^receiveDfuResultBlock)(NSString *gatewayMacAddress, NSString *deviceMacAddress, NSInteger resultCode);

/// 设备跟当前网关断开连接了，gatewayMacAddress当前网关设备的mac,deviceMacAddress当前网关连接的设备的mac
@property (nonatomic, copy)void (^deviceDisconnectBlock)(NSString *gatewayMacAddress, NSString *deviceMacAddress);

@property (nonatomic, copy)NSString *firmwareUrl;

@property (nonatomic, copy)NSString *dataUrl;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
