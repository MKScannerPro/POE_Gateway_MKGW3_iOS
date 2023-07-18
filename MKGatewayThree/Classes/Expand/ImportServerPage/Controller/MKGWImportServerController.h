//
//  MKGWImportServerController.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/7.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKGWImportServerControllerDelegate <NSObject>

- (void)gw_selectedServerParams:(NSString *)fileName;

@end

@interface MKGWImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKGWImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
