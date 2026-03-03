//
//  MKGWOTAPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/13.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerOTAProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWOTAPageModel : NSObject<MKScannerOTAProtocol>

/// 0:Wifi OTA   1:NCP OTA
@property (nonatomic, assign)NSInteger otaType;

@property (nonatomic, copy)NSString *filePath;

@property (nonatomic, copy)void (^receiveOTAResult)(NSInteger result);

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
