//
//  MKScannerMqttServerLwtView.h
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/3/1.
//  Copyright © 2026 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKScannerMqttServerLwtViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKScannerMqttServerLwtViewDelegate <NSObject>

- (void)mk_scanner_lwt_statusChanged:(BOOL)isOn;

- (void)mk_scanner_lwt_retainChanged:(BOOL)isOn;

- (void)mk_scanner_lwt_qosChanged:(NSInteger)qos;

- (void)mk_scanner_lwt_topicChanged:(NSString *)text;

- (void)mk_scanner_lwt_payloadChanged:(NSString *)text;

@end

@interface MKScannerMqttServerLwtView : UIView

@property (nonatomic, strong)MKScannerMqttServerLwtViewModel *dataModel;

@property (nonatomic, weak)id <MKScannerMqttServerLwtViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
