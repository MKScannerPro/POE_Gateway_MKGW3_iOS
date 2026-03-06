//
//  MKGWBXPCAccDataPageModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/4.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerAccDataProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWBXPCAccDataPageModel : NSObject<MKScannerAccDataProtocol>

/// 发送邮件的时候的文件名字:BXP-D AccData.txt
@property (nonatomic, copy)NSString *mailFileName;

@property (nonatomic, copy)void (^receiveAccDataBlock)(NSString *xAxis, NSString *yAxis, NSString *zAxis);

/// 监听Acc数据
- (void)notifyAccData:(BOOL)isOn
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
