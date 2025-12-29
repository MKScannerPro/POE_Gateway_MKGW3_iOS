//
//  MKGWFilterByNanoBeaconModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/10/20.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterByNanoBeaconModel : NSObject

@property (nonatomic, assign)BOOL isOn;

/// 0:Normal type 1:Trigger type 2:All
@property (nonatomic, assign)NSInteger triggerType;

@property (nonatomic, strong)NSArray *manufactureList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithManufactureList:(NSArray <NSString *>*)manufactureList
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
