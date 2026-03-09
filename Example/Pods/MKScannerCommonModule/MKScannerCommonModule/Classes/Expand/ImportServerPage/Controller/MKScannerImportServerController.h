//
//  MKScannerImportServerController.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKScannerImportServerControllerDelegate <NSObject>

- (void)mk_scanner_selectedServerParams:(NSString *)fileName;

@end

@interface MKScannerImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKScannerImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
