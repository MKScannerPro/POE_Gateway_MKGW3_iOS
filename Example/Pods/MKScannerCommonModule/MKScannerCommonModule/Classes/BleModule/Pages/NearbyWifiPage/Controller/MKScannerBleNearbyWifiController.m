//
//  MKScannerBleNearbyWifiController.m
//  MKScannerCommonModule_Example
//
//  Created by aa on 2026/2/26.
//  Copyright © 2026 lovexiaoxia. All rights reserved.
//

#import "MKScannerBleNearbyWifiController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKHudManager.h"

#import "MKScannerBleNearbyWifiCell.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKScannerBleNearbyWifiController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)id <MKScannerBleNearbyWifiProtocol>protocol;

@property (nonatomic, strong)NSMutableArray *contentList;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)dispatch_source_t contentTimer;

@property (nonatomic, assign)NSInteger contentTimeCount;

@property (nonatomic, assign)BOOL contentReceiveTimeout;

@end

@implementation MKScannerBleNearbyWifiController

- (void)dealloc {
    NSLog(@"MKScannerBleNearbyWifiController销毁");
    if (self.contentTimer) {
        dispatch_cancel(self.contentTimer);
    }
}

- (instancetype)initWithProtocol:(id<MKScannerBleNearbyWifiProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
        [self setupReceiveBlock];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self startScanWifi];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKScannerBleNearbyWifiCellModel *cellModel = self.dataList[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(mk_scanner_nearbyWifiController_selectedWifi:)]) {
        [self.delegate mk_scanner_nearbyWifiController_selectedWifi:cellModel.ssid];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKScannerBleNearbyWifiCell *cell = [MKScannerBleNearbyWifiCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)startScanWifi {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.protocol startWifiScanWithSucBlock:^{
        [[MKHudManager share] hide];
        [self.dataList removeAllObjects];
        [self.contentList removeAllObjects];
        [[MKHudManager share] showHUDWithTitle:@"Loading..." inView:self.view isPenetration:NO];
        [self contentTimerRun];
    }
                                 failedBlock:^(NSError *error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - Private method
- (void)setupReceiveBlock {
    @weakify(self);
    self.protocol.receiveWifiBlock = ^(NSString *content) {
        @strongify(self);
        [self handleReceivedWifiData:content];
    };
}

- (void)handleReceivedWifiData:(NSString *)content {
    if (self.contentReceiveTimeout || !ValidStr(content) || content.length < 6) {
        return;
    }
    NSLog(@"接收到数据:%@",content);
    self.contentTimeCount = 0;
    
    NSInteger index = 0;
    NSInteger totalPacket = strtoul([[content substringWithRange:NSMakeRange(index, 2)] UTF8String],0,16);
    index += 2;
    NSInteger packetIndex = strtoul([[content substringWithRange:NSMakeRange(index, 2)] UTF8String],0,16);
    index += 2;
    NSInteger totalDataLen = strtoul([[content substringWithRange:NSMakeRange(index, 2)] UTF8String],0,16);
    index += 2;
    
    [self.contentList addObject:[content substringFromIndex:index]];
    
    if (totalPacket == self.contentList.count) {
        //接受数据完成，开始解析
        if (self.contentTimer) {
            dispatch_cancel(self.contentTimer);
        }
        self.contentTimeCount = 0;
        self.contentReceiveTimeout = NO;
        [self parseContentList];
        return;
    }
}

- (void)parseContentList {
    NSString *content = @"";
    for (NSInteger i = 0; i < self.contentList.count; i ++) {
        content = [content stringByAppendingString:self.contentList[i]];
    }
    NSUInteger length = content.length;
    NSUInteger index = 0;

    while (index < length) {
        // 检查第一个字节是否是 00
        NSString *startString = [content substringWithRange:NSMakeRange(index, 2)];
        if (![startString isEqualToString:@"00"]) {
            break;
        }
        index += 2;

        // 读取 BSSID 长度
        if (index >= length) break;
        NSInteger bssidLength = strtoul([[content substringWithRange:NSMakeRange(index, 2)] UTF8String],0,16);
        index += 2;
        
        if (index + bssidLength > length) break; // 确保不会越界

        // 读取 BSSID 数据
        NSString *bssid = [content substringWithRange:NSMakeRange(index, 2 * bssidLength)];
        index += (2 * bssidLength);

        // 创建模型对象
        MKScannerBleNearbyWifiCellModel *model = [[MKScannerBleNearbyWifiCellModel alloc] init];
        model.bssid = bssid;

        // 解析类型和数据项
        while (index < length) {
            // 读取类型（01 或 02）
            if (index >= length) break;
            NSString *type = [content substringWithRange:NSMakeRange(index, 2)];
            if ([type isEqualToString:@"00"]) {
                break;
            }
            index += 2;
            // 读取数据长度
            if (index >= length) break;
            NSInteger dataLength = strtoul([[content substringWithRange:NSMakeRange(index, 2)] UTF8String],0,16);
            index += 2;
            if (index + dataLength > length) break; // 确保不会越界
            
            // 根据类型设置属性
            if ([type isEqualToString:@"01"]) {
                NSString *dataString = [content substringWithRange:NSMakeRange(index, 2 * dataLength)];
                model.ssid = [[NSString alloc] initWithData:[dataString stringToData] encoding:NSUTF8StringEncoding];
            } else if ([type isEqualToString:@"02"]) {
                // 处理有符号的十六进制 RSSI 数据
                model.rssi = [self signedHexTurnString:[content substringWithRange:NSMakeRange(index, 2 * dataLength)]];
            }
            index += (dataLength * 2);
        }

        // 添加模型对象到全局数组
        [self.dataList addObject:model];
    }
    [[MKHudManager share] hide];
    [self.tableView reloadData];
}

- (void)contentTimerRun{
    if (self.contentTimer) {
        dispatch_cancel(self.contentTimer);
    }
    self.contentTimeCount = 0;
    self.contentReceiveTimeout = NO;
    self.contentTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_global_queue(0, 0));
    //开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC);
    //间隔时间
    uint64_t interval = NSEC_PER_SEC;
    dispatch_source_set_timer(self.contentTimer, start, interval, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.contentTimer, ^{
        @strongify(self);
        NSLog(@"接收到数据");
        self.contentTimeCount ++;
        if (self.contentTimeCount >= 8) {
            dispatch_cancel(self.contentTimer);
            self.contentTimeCount = 0;
            self.contentReceiveTimeout = YES;
            moko_dispatch_main_safe(^{
                [[MKHudManager share] hide];
            });
            return;
        }
    });
    dispatch_resume(self.contentTimer);
}

- (NSNumber *)signedHexTurnString:(NSString *)content {
    // 将十六进制字符串转换为无符号整数值
    NSScanner *scanner = [NSScanner scannerWithString:content];
    unsigned long long unsignedValue = 0;
    [scanner scanHexLongLong:&unsignedValue];
    
    // 计算字节数
    NSInteger byteLength = (content.length + 1) / 2;
    
    // 根据字节数进行有符号转换
    switch (byteLength) {
        case 1:  // 1字节：范围 -128 ~ 127
            return @((int8_t)unsignedValue);
        case 2:  // 2字节：范围 -32768 ~ 32767
            return @((int16_t)unsignedValue);
        case 4:  // 4字节：范围 -2147483648 ~ 2147483647
            return @((int32_t)unsignedValue);
        case 8:  // 8字节：范围 -2^63 ~ 2^63-1
            return @((int64_t)unsignedValue);
        default:
            // 如果字节数不是标准长度，使用数学方法
            return [self signedHexForArbitraryLength:content unsignedValue:unsignedValue];
    }
}

- (NSNumber *)signedHexForArbitraryLength:(NSString *)content unsignedValue:(unsigned long long)unsignedValue {
    NSInteger bitLength = content.length * 4; // 每个十六进制字符4位
    
    // 检查最高位是否为1（判断是否为负数）
    unsigned long long highestBitMask = 1ULL << (bitLength - 1);
    if (unsignedValue & highestBitMask) {
        // 负数：计算补码对应的有符号值
        unsigned long long maxValue = (1ULL << bitLength) - 1;
        long long signedValue = (long long)(unsignedValue - maxValue - 1);
        return @(signedValue);
    } else {
        // 正数直接返回
        return @(unsignedValue);
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Nearby WIFI";
    [self.rightButton setImage:LOADICON(@"MKScannerCommonModule", @"MKScannerBleNearbyWifiController", @"mk_scanner_refreshWifiListIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableArray *)contentList {
    if (!_contentList) {
        _contentList = [NSMutableArray array];
    }
    return _contentList;
}

@end
