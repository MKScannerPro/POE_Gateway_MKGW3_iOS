//
//  MKGWButtonDFUV2Model.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/6/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerButtonDfuV2Protocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWButtonDFUV2Model : NSObject<MKScannerButtonDfuV2Protocol>

/// dfu升级百分比，gatewayMacAddress当前网关设备的mac，deviceMacAddress当前网关连接的设备的mac，percent当前百分比
@property (nonatomic, copy)void (^receiveDfuProgressBlock)(NSString *gatewayMacAddress, NSString *deviceMacAddress, NSString *percent);

/// dfu升级完成，gatewayMacAddress当前网关设备的mac，deviceMacAddress当前网关连接的设备的mac, resultCode=0表明升级成功
@property (nonatomic, copy)void (^receiveDfuResultBlock)(NSString *gatewayMacAddress, NSString *deviceMacAddress, NSInteger resultCode);

/// 设备跟当前网关断开连接了，gatewayMacAddress当前网关设备的mac,deviceMacAddress当前网关连接的设备的mac
@property (nonatomic, copy)void (^deviceDisconnectBlock)(NSString *gatewayMacAddress, NSString *deviceMacAddress);

@property (nonatomic, copy)NSString *firmwareUrl;

@property (nonatomic, copy)NSString *dataUrl;

/// 1:BXP-B-D   2:BXP-B-CR  3:BXP-C 4:BXP-D 5:BXP-TAG   6:BXP-S 7:PIR   8:TOF
@property (nonatomic, assign)NSInteger type;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
