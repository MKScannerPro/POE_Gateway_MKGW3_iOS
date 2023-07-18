//
//  MKGWDeviceDataPageCell.h
//  MKGatewayThree_Example
//
//  Created by aa on 2023/2/4.
//  Copyright © 2023 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKGWDeviceDataPageCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

- (CGFloat)fetchCellHeight;

@end

@interface MKGWDeviceDataPageCell : MKBaseCell

+ (MKGWDeviceDataPageCell *)initCellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)MKGWDeviceDataPageCellModel *dataModel;

@end

NS_ASSUME_NONNULL_END
