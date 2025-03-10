//
//  MKGWManageBleDevicesTypeSelectedView.h
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKGWManageBleDevicesTypeSelectedViewType) {
    MKGWManageBleDevicesTypeSelectedViewTypeBXPBD,
    MKGWManageBleDevicesTypeSelectedViewTypeBXPBCR,
    MKGWManageBleDevicesTypeSelectedViewTypeBXPC,
    MKGWManageBleDevicesTypeSelectedViewTypeBXPD,
    MKGWManageBleDevicesTypeSelectedViewTypeBXPT,
    MKGWManageBleDevicesTypeSelectedViewTypeBXPS,
    MKGWManageBleDevicesTypeSelectedViewTypePIR,
    MKGWManageBleDevicesTypeSelectedViewTypeTOF,
    MKGWManageBleDevicesTypeSelectedViewTypeOther,
};

@interface MKGWManageBleDevicesTypeSelectedView : UIView

+ (void)showWithType:(MKGWManageBleDevicesTypeSelectedViewType)type
        selecteBlock:(void (^)(MKGWManageBleDevicesTypeSelectedViewType selectedType))selecteBlock;

@end

NS_ASSUME_NONNULL_END
