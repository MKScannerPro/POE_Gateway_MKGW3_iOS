//
//  MKGWFilterByOtherModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKGWMQTTConfigDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKGWFilterRawAdvDataModel : NSObject<mk_gw_BLEFilterRawDataProtocol>

@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:62 Bytes,maxIndex - minIndex <= 29 Bytes
@property (nonatomic, copy)NSString *rawData;

- (BOOL)validParams;

@end

@interface MKGWFilterByOtherModel : NSObject

@property (nonatomic, assign)BOOL isOn;

/*
 0:A
 1:A & B
 2:A | B
 3:A & B & C
 4:(A & B) | C
 5:A | B | C
 */
@property (nonatomic, assign)NSInteger relationship;

@property (nonatomic, strong)NSArray *rawDataList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configWithRawDataList:(NSArray <MKGWFilterRawAdvDataModel *>*)list
                 relationship:(mk_gw_filterByOther)relationship
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
