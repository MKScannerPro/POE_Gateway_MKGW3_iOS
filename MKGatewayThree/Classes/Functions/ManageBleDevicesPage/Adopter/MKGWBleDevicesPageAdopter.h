//
//  MKGWBleDevicesPageAdopter.h
//  MKGatewayThree_Example
//
//  Created by aa on 2026/3/5.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGWManageBleDevicesType) {
    MKGWManageBleDevicesTypeBXPBD,
    MKGWManageBleDevicesTypeBXPBCR,
    MKGWManageBleDevicesTypeBXPC,
    MKGWManageBleDevicesTypeBXPD,
    MKGWManageBleDevicesTypeBXPT,
    MKGWManageBleDevicesTypeBXPS,
    MKGWManageBleDevicesTypePIR,
    MKGWManageBleDevicesTypeTOF,
    MKGWManageBleDevicesTypeOther,
};

@interface MKGWBleDevicesPageAdopter : NSObject

+ (UIViewController *)loadBXPBCRPage;

+ (UIViewController *)loadBXPBDPage;

+ (UIViewController *)loadBXPCPage;

+ (UIViewController *)loadBXPDPage;

+ (UIViewController *)loadBXPSPage;

+ (UIViewController *)loadBXPTPage;

+ (UIViewController *)loadMKPirPage;

+ (UIViewController *)loadMKTofPage;

+ (UIViewController *)loadNormalConnectedPage;

/// 连接设备.连接设备之后，当前设备信息会放在MKGWManageBleDevicesManager管理
/// - Parameters:
///   - bleMac: 要连接设备的mac地址
///   - type: 要连接设备的类型
///   - password: 密码
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
+ (void)connectPeripheral:(NSString *)bleMac
                     type:(MKGWManageBleDevicesType)type
                 password:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// 读取连接设备的信息。读取之后，当前设备信息会放在MKGWManageBleDevicesManager管理
/// - Parameters:
///   - bleMac: 要读取设备的mac地址
///   - type: 要读取设备的类型
///   - sucBlock: 成功回调
///   - failedBlock: 失败回调
+ (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac
                                     type:(MKGWManageBleDevicesType)type
                                 sucBlock:(void (^)(void))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;



@end

NS_ASSUME_NONNULL_END
