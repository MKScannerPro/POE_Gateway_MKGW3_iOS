//
//  MKScannerManageBleDevicesTypeSelectedView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/28.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKScannerManageBleDevicesTypeSelectedViewType) {
    MKScannerManageBleDevicesTypeSelectedViewTypeBXPBD,
    MKScannerManageBleDevicesTypeSelectedViewTypeBXPBCR,
    MKScannerManageBleDevicesTypeSelectedViewTypeBXPC,
    MKScannerManageBleDevicesTypeSelectedViewTypeBXPD,
    MKScannerManageBleDevicesTypeSelectedViewTypeBXPT,
    MKScannerManageBleDevicesTypeSelectedViewTypeBXPS,
    MKScannerManageBleDevicesTypeSelectedViewTypePIR,
    MKScannerManageBleDevicesTypeSelectedViewTypeTOF,
    MKScannerManageBleDevicesTypeSelectedViewTypeOther,
};

@interface MKScannerManageBleDevicesTypeSelectedView : UIView

+ (void)showWithType:(MKScannerManageBleDevicesTypeSelectedViewType)type
        selecteBlock:(void (^)(MKScannerManageBleDevicesTypeSelectedViewType selectedType))selecteBlock;

@end

NS_ASSUME_NONNULL_END
