//
//  MKGWFilterByTofModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2024/11/01.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterByTofModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, strong)NSArray *codeList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithCodeList:(NSArray <NSString *>*)codeList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
