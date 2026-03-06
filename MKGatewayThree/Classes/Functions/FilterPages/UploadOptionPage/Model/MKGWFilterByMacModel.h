//
//  MKGWFilterByMacModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/6..
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKScannerFilterByMacProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterByMacModel : NSObject<MKScannerFilterByMacProtocol>

@property (nonatomic, assign)BOOL preciseMatch;

@property (nonatomic, assign)BOOL reverseFilter;

@property (nonatomic, strong)NSArray *dataList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithMacList:(NSArray <NSString *>*)macList
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
