//
//  MKGWUploadDataOptionModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGWMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWUploadDataOptionModel : NSObject<gw_uploadDataOptionProtocol>

/// V2版本固件
@property (nonatomic, assign)BOOL isV2;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL rawData_advertising;

@property (nonatomic, assign)BOOL rawData_response;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
