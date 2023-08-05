//
//  MKGWUploadOptionModel.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/6.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWUploadOptionModel : NSObject

@property (nonatomic, assign)NSInteger rssi;

/*
 0：1M PHY(V4.2)
 1：1M PHY(V5.0)
 2：1M PHY(V4.2) & 1M PHY(V5.0)
 3：Coded PHY(V5.0)
 */
@property (nonatomic, assign)NSInteger phy;

/// 0:Null   1:Only MAC    2:Only ADV Name   3:Only RAW DATA 4:ADV name&Raw data   5:MAC&ADV name&Raw data  6:ADV name | Raw data  7:ADV name&MAC
@property (nonatomic, assign)NSInteger relationship;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
