//
//  MKGWButtonDFUV2Model.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/6/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWButtonDFUV2Model : NSObject

@property (nonatomic, copy)NSString *bleMac;

@property (nonatomic, copy)NSString *firmwareUrl;

@property (nonatomic, copy)NSString *dataUrl;

/// 1:BXP-B-D   2:BXP-B-CR  3:BXP-C 4:BXP-D 5:BXP-TAG   6:BXP-S 7:PIR   8:TOF
@property (nonatomic, assign)NSInteger type;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
