//
//  MKGWBleNetworkSettingsV2Controller.m
//  MKGatewayThree_Example
//
//  Created by aa on 2025/1/15.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKGWBleNetworkSettingsV2Controller.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSString+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKTextButtonCell.h"
#import "MKTextFieldCell.h"
#import "MKTextSwitchCell.h"
#import "MKCAFileSelectController.h"

#import "MKGWDeviceModel.h"

#include "MKGWBleWifiSettingsCertCell.h"

#import "MKGWDeviceMQTTParamsModel.h"

#import "MKGWBleNetworkSettingsV2Model.h"

#import "MKGWNetworkSsidSettingsCell.h"

#import "MKGWNearbyWifiController.h"

static NSString *const noteMsg = @"Please note the CA certificate is required, the client certificate and client key are optional.";

@interface MKGWBleNetworkSettingsV2Controller ()<UITableViewDelegate,
UITableViewDataSource,
MKTextButtonCellDelegate,
MKTextFieldCellDelegate,
mk_textSwitchCellDelegate,
MKGWBleWifiSettingsCertCellDelegate,
MKCAFileSelectControllerDelegate,
MKGWNetworkSsidSettingsCellDelegate,
MKGWNearbyWifiControllerDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *section8List;

@property (nonatomic, strong)NSMutableArray *section9List;

@property (nonatomic, strong)NSMutableArray *section10List;

@property (nonatomic, strong)NSMutableArray *section11List;

@property (nonatomic, strong)NSMutableArray *section12List;

@property (nonatomic, strong)NSMutableArray *section13List;

@property (nonatomic, strong)NSMutableArray *section14List;

@property (nonatomic, strong)NSMutableArray *section15List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)UILabel *noteLabel;

@property (nonatomic, strong)MKGWBleNetworkSettingsV2Model *dataModel;

@end

@implementation MKGWBleNetworkSettingsV2Controller

- (void)dealloc {
    NSLog(@"MKGWBleNetworkSettingsV2Controller销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 3 || section == 14) {
        return 10.f;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellForRowAtIndexPath:indexPath];
}

#pragma mark - MKTextButtonCellDelegate
/// 右侧按钮点击触发的回调事件
/// @param index 当前cell所在的index
/// @param dataListIndex 点击按钮选中的dataList里面的index
/// @param value dataList[dataListIndex]
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    if (index == 0) {
        //Type
        self.dataModel.networkType = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section0List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView reloadData];
        return;
    }
    if (index == 1) {
        //Security
        self.dataModel.security = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section3List[0];
        cellModel.dataListIndex = dataListIndex;
        [self.tableView reloadData];
        return;
    }
    if (index == 2) {
        //EAP type
        self.dataModel.eapType = dataListIndex;
        MKTextButtonCellModel *cellModel = self.section4List[0];
        cellModel.dataListIndex = dataListIndex;
        self.noteLabel.hidden = (self.dataModel.eapType != 2);
        [self.tableView reloadData];
        return;
    }
}

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Ethernet IP
        self.dataModel.ethernet_ip = value;
        MKTextFieldCellModel *cellModel = self.section2List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Mask
        self.dataModel.ethernet_mask = value;
        MKTextFieldCellModel *cellModel = self.section2List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 2) {
        //Gateway
        self.dataModel.ethernet_gateway = value;
        MKTextFieldCellModel *cellModel = self.section2List[2];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 3) {
        //DNS
        self.dataModel.ethernet_dns = value;
        MKTextFieldCellModel *cellModel = self.section2List[3];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 5) {
        //WIFI Password
        self.dataModel.wifiPassword = value;
        MKTextFieldCellModel *cellModel = self.section6List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 6) {
        //EAP Username
        self.dataModel.eapUserName = value;
        MKTextFieldCellModel *cellModel = self.section7List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 7) {
        //Password
        self.dataModel.eapPassword = value;
        MKTextFieldCellModel *cellModel = self.section8List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 8) {
        //Domain ID
        self.dataModel.domainID = value;
        MKTextFieldCellModel *cellModel = self.section9List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 9) {
        //IP
        self.dataModel.wifi_ip = value;
        MKTextFieldCellModel *cellModel = self.section15List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 10) {
        //Mask
        self.dataModel.wifi_mask = value;
        MKTextFieldCellModel *cellModel = self.section15List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 11) {
        //Gateway
        self.dataModel.wifi_gateway = value;
        MKTextFieldCellModel *cellModel = self.section15List[2];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 12) {
        //DNS
        self.dataModel.wifi_dns = value;
        MKTextFieldCellModel *cellModel = self.section15List[3];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Ethernet DHCP
        self.dataModel.ethernet_dhcp = isOn;
        MKTextSwitchCellModel *cellModel = self.section1List[0];
        cellModel.isOn = isOn;
        [self.tableView mk_reloadSection:2 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 1) {
        //Verify server
        self.dataModel.verifyServer = isOn;
        MKTextSwitchCellModel *cellModel = self.section10List[0];
        cellModel.isOn = isOn;
        
        [self.tableView mk_reloadSection:11 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (index == 2) {
        //Wifi DHCP
        self.dataModel.wifi_dhcp = isOn;
        MKTextSwitchCellModel *cellModel = self.section14List[0];
        cellModel.isOn = isOn;
        [self.tableView mk_reloadSection:15 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

#pragma mark - MKGWBleWifiSettingsCertCellDelegate
- (void)gw_bleWifiSettingsCertPressed:(NSInteger)index {
    if (index == 0) {
        //CA certificate
        MKCAFileSelectController *vc = [[MKCAFileSelectController alloc] init];
        vc.pageType = mk_caCertSelPage;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (index == 1) {
        //Client certificate
        MKCAFileSelectController *vc = [[MKCAFileSelectController alloc] init];
        vc.pageType = mk_clientCertSelPage;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    if (index == 2) {
        //Client key
        MKCAFileSelectController *vc = [[MKCAFileSelectController alloc] init];
        vc.pageType = mk_clientKeySelPage;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark - MKCAFileSelectControllerDelegate
- (void)mk_certSelectedMethod:(mk_certListPageType)certType certName:(NSString *)certName {
    if (certType == mk_caCertSelPage) {
        //CA certificate
        self.dataModel.caFileName = certName;
        MKGWBleWifiSettingsCertCellModel *cellModel = self.section11List[0];
        cellModel.fileName = certName;
        [self.tableView mk_reloadSection:11 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (certType == mk_clientCertSelPage) {
        //Client certificate
        self.dataModel.clientCertName = certName;
        MKGWBleWifiSettingsCertCellModel *cellModel = self.section12List[0];
        cellModel.fileName = certName;
        [self.tableView mk_reloadSection:12 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
    if (certType == mk_clientKeySelPage) {
        //Client key
        self.dataModel.clientKeyName = certName;
        MKGWBleWifiSettingsCertCellModel *cellModel = self.section13List[0];
        cellModel.fileName = certName;
        [self.tableView mk_reloadSection:13 withRowAnimation:UITableViewRowAnimationNone];
        return;
    }
}

#pragma mark - MKGWNetworkSsidSettingsCellDelegate
- (void)gw_networkSsidSettingsCell_ssidChanged:(NSString *)ssid {
    //SSID
    self.dataModel.ssid = ssid;
    MKGWNetworkSsidSettingsCellModel *cellModel = self.section5List[0];
    cellModel.ssid = ssid;
}

- (void)gw_networkSsidSettingsCell_buttonPressed {
    MKGWNearbyWifiController *vc = [[MKGWNearbyWifiController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MKGWNearbyWifiControllerDelegate
- (void)gw_nearbyWifiController_selectedWifi:(NSString *)ssid {
    MKGWNetworkSsidSettingsCellModel *cellModel = self.section5List[0];
    cellModel.ssid = ssid;
    self.dataModel.ssid = ssid;
    
    [self.tableView mk_reloadSection:5 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
        [MKGWDeviceMQTTParamsModel shared].wifiConfig = YES;
        [MKGWDeviceMQTTParamsModel shared].deviceModel.networkType = [NSString stringWithFormat:@"%ld",(long)self.dataModel.networkType];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        [MKGWDeviceMQTTParamsModel shared].wifiConfig = NO;
    }];
}

#pragma mark - table数据处理方法
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //Type
        return self.section0List.count;
    }
    if (section == 1) {
        //Ethernet DHCP
        return (self.dataModel.networkType != 1) ? self.section1List.count : 0;
    }
    if (section == 2) {
        if (self.dataModel.networkType != 1) {
            //Ethernet IP
            return (self.dataModel.ethernet_dhcp ? 0 : self.section2List.count);
        }
        return 0;
    }
    if (self.dataModel.networkType == 0) {
        return 0;
    }
    if (section == 3) {
        //Security
        return self.section3List.count;
    }
    if (section == 4) {
        //EAP type
        return (self.dataModel.security == 1 ? self.section4List.count : 0);
    }
    if (section == 5) {
        //SSID
        return self.section5List.count;
    }
    if (section == 6) {
        //WIFI Password.Security为Personal有效
        return (self.dataModel.security == 0 ? self.section6List.count : 0);
    }
    if (section == 7) {
        //EAP Username   Security为Enterprise && EAP type为PEAP-MSCHAPV2或者TTLS -MSCHAPV2
        if (self.dataModel.security == 1 && (self.dataModel.eapType == 0 || self.dataModel.eapType == 1)) {
            return self.section7List.count;
        }
        return 0;
    }
    if (section == 8) {
        //EAP Password
        if ((self.dataModel.security == 0) || (self.dataModel.security == 1 && self.dataModel.eapType == 2)) {
            //Security为Personal和TLS没有此选项
            return 0;
        }
        return self.section8List.count;
    }
    if (section == 9) {
        //Domain ID. TLS特有
        return ((self.dataModel.security == 1 && self.dataModel.eapType == 2) ? self.section9List.count : 0);
    }
    if (section == 10) {
        //Verify server. Security为Enterprise && EAP type为PEAP-MSCHAPV2或者TTLS -MSCHAPV2
        if (self.dataModel.security == 1 && (self.dataModel.eapType == 0 || self.dataModel.eapType == 1)) {
            return self.section10List.count;
        }
        
    }
    if (section == 11) {
        //CA certificate.Security为Enterprise有效
        if (self.dataModel.security == 1) {
            if (!self.dataModel.verifyServer && (self.dataModel.eapType == 0 || self.dataModel.eapType == 1)) {
                return 0;
            }
            return self.section11List.count;
        }
    }
    if (section == 12) {
        //Client certificate.TLS特有
        return ((self.dataModel.security == 1 && self.dataModel.eapType == 2) ? self.section12List.count : 0);
    }
    if (section == 13) {
        //Client key.TLS特有
        return ((self.dataModel.security == 1 && self.dataModel.eapType == 2) ? self.section13List.count : 0);
    }
    
    if (section == 14) {
        //WIFI DHCP
        return self.section14List.count;
    }
    if (section == 15) {
        //WIFI IP
        return (self.dataModel.wifi_dhcp ? 0 : self.section15List.count);
    }
    
    return 0;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //Type
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        //Ethernet DHCP
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        //Ethernet IP
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        //Security
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        //EAP type
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 5) {
        //SSID
        MKGWNetworkSsidSettingsCell *cell = [MKGWNetworkSsidSettingsCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section5List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 6) {
        //WIFI Password
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section6List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 7) {
        //EAP Username
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section7List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 8) {
        //EAP Password
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section8List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 9) {
        //Domain ID.
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section9List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 10) {
        //Verify server.
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section10List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 11) {
        //CA certificate.
        MKGWBleWifiSettingsCertCell *cell = [MKGWBleWifiSettingsCertCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section11List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 12) {
        //Client certificate.TLS特有
        MKGWBleWifiSettingsCertCell *cell = [MKGWBleWifiSettingsCertCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section12List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 13) {
        //CA certificate
        MKGWBleWifiSettingsCertCell *cell = [MKGWBleWifiSettingsCertCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section13List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 14) {
        //Wifi DHCP
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section14List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    //Wifi IP
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
    cell.dataModel = self.section15List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
    [self loadSection8Datas];
    [self loadSection9Datas];
    [self loadSection10Datas];
    [self loadSection11Datas];
    [self loadSection12Datas];
    [self loadSection13Datas];
    [self loadSection14Datas];
    [self loadSection15Datas];
    
    for (NSInteger i = 0; i < 16; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    self.noteLabel.hidden = (self.dataModel.eapType != 2);
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Type";
    cellModel.buttonLabelFont = MKFont(13.f);
    cellModel.dataList = @[@"ETH",@"WIFI",@"ETH->WIFI",@"WIFI->ETH"];
    cellModel.dataListIndex = self.dataModel.networkType;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Ethernet DHCP";
    cellModel.isOn = self.dataModel.ethernet_dhcp;
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Ethernet IP";
    cellModel1.textFieldType = mk_normal;
    cellModel1.textFieldValue = self.dataModel.ethernet_ip;
    [self.section2List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Ethernet Mask";
    cellModel2.textFieldType = mk_normal;
    cellModel2.textFieldValue = self.dataModel.ethernet_mask;
    [self.section2List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = @"Ethernet Gateway";
    cellModel3.textFieldType = mk_normal;
    cellModel3.textFieldValue = self.dataModel.ethernet_gateway;
    [self.section2List addObject:cellModel3];
    
    MKTextFieldCellModel *cellModel4 = [[MKTextFieldCellModel alloc] init];
    cellModel4.index = 3;
    cellModel4.msg = @"Ethernet DNS";
    cellModel4.textFieldType = mk_normal;
    cellModel4.textFieldValue = self.dataModel.ethernet_dns;
    [self.section2List addObject:cellModel4];
}

- (void)loadSection3Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Security";
    cellModel.buttonLabelFont = MKFont(13.f);
    cellModel.dataList = @[@"Personal",@"Enterprise"];
    cellModel.dataListIndex = self.dataModel.security;
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKTextButtonCellModel *cellModel = [[MKTextButtonCellModel alloc] init];
    cellModel.index = 2;
    cellModel.msg = @"EAP type";
    cellModel.buttonLabelFont = MKFont(13.f);
    cellModel.dataList = @[@"PEAP-MSCHAPV2",@"TTLS-MSCHAPV2",@"TLS"];
    cellModel.dataListIndex = self.dataModel.eapType;
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKGWNetworkSsidSettingsCellModel *cellModel = [[MKGWNetworkSsidSettingsCellModel alloc] init];
    cellModel.ssid = self.dataModel.ssid;
    [self.section5List addObject:cellModel];
}

- (void)loadSection6Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 5;
    cellModel.msg = @"Password";
    cellModel.maxLength = 64;
    cellModel.textPlaceholder = @"0-64 Characters";
    cellModel.textFieldType = mk_normal;
    cellModel.textFieldValue = self.dataModel.wifiPassword;
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 6;
    cellModel.msg = @"EAP username";
    cellModel.maxLength = 32;
    cellModel.textPlaceholder = @"0-32 Characters";
    cellModel.textFieldType = mk_normal;
    cellModel.textFieldValue = self.dataModel.eapUserName;
    [self.section7List addObject:cellModel];
}

- (void)loadSection8Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 7;
    cellModel.msg = @"EAP password";
    cellModel.maxLength = 64;
    cellModel.textPlaceholder = @"0-64 Characters";
    cellModel.textFieldType = mk_normal;
    cellModel.textFieldValue = self.dataModel.eapPassword;
    [self.section8List addObject:cellModel];
}

- (void)loadSection9Datas {
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 8;
    cellModel.msg = @"Domain ID";
    cellModel.maxLength = 64;
    cellModel.textPlaceholder = @"0-64 Characters";
    cellModel.textFieldType = mk_normal;
    cellModel.textFieldValue = self.dataModel.domainID;
    [self.section9List addObject:cellModel];
}

- (void)loadSection10Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Verify server";
    cellModel.isOn = self.dataModel.verifyServer;
    [self.section10List addObject:cellModel];
}

- (void)loadSection11Datas {
    MKGWBleWifiSettingsCertCellModel *cellModel = [[MKGWBleWifiSettingsCertCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"CA certificate";
    cellModel.fileName = self.dataModel.caFileName;
    [self.section11List addObject:cellModel];
}

- (void)loadSection12Datas {
    MKGWBleWifiSettingsCertCellModel *cellModel = [[MKGWBleWifiSettingsCertCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Client certificate";
    cellModel.fileName = self.dataModel.clientCertName;
    [self.section12List addObject:cellModel];
}

- (void)loadSection13Datas {
    MKGWBleWifiSettingsCertCellModel *cellModel = [[MKGWBleWifiSettingsCertCellModel alloc] init];
    cellModel.index = 2;
    cellModel.msg = @"Client key";
    cellModel.fileName = self.dataModel.clientKeyName;
    [self.section13List addObject:cellModel];
}

- (void)loadSection14Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 2;
    cellModel.msg = @"WIFI DHCP";
    cellModel.isOn = self.dataModel.wifi_dhcp;
    [self.section14List addObject:cellModel];
}

- (void)loadSection15Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 9;
    cellModel1.msg = @"WIFI IP";
    cellModel1.textFieldType = mk_normal;
    cellModel1.textFieldValue = self.dataModel.wifi_ip;
    [self.section15List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 10;
    cellModel2.msg = @"WIFI Mask";
    cellModel2.textFieldType = mk_normal;
    cellModel2.textFieldValue = self.dataModel.wifi_mask;
    [self.section15List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.index = 11;
    cellModel3.msg = @"WIFI Gateway";
    cellModel3.textFieldType = mk_normal;
    cellModel3.textFieldValue = self.dataModel.wifi_gateway;
    [self.section15List addObject:cellModel3];
    
    MKTextFieldCellModel *cellModel4 = [[MKTextFieldCellModel alloc] init];
    cellModel4.index = 12;
    cellModel4.msg = @"WIFI DNS";
    cellModel4.textFieldType = mk_normal;
    cellModel4.textFieldValue = self.dataModel.wifi_dns;
    [self.section15List addObject:cellModel4];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Network Settings";
    [self.rightButton setImage:LOADICON(@"MKGatewayThree", @"MKGWBleNetworkSettingsV2Controller", @"gw_saveIcon.png") forState:UIControlStateNormal];
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
        _tableView.tableFooterView = [self tableFooterView];
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)section6List {
    if (!_section6List) {
        _section6List = [NSMutableArray array];
    }
    return _section6List;
}

- (NSMutableArray *)section7List {
    if (!_section7List) {
        _section7List = [NSMutableArray array];
    }
    return _section7List;
}

- (NSMutableArray *)section8List {
    if (!_section8List) {
        _section8List = [NSMutableArray array];
    }
    return _section8List;
}

- (NSMutableArray *)section9List {
    if (!_section9List) {
        _section9List = [NSMutableArray array];
    }
    return _section9List;
}

- (NSMutableArray *)section10List {
    if (!_section10List) {
        _section10List = [NSMutableArray array];
    }
    return _section10List;
}

- (NSMutableArray *)section11List {
    if (!_section11List) {
        _section11List = [NSMutableArray array];
    }
    return _section11List;
}

- (NSMutableArray *)section12List {
    if (!_section12List) {
        _section12List = [NSMutableArray array];
    }
    return _section12List;
}

- (NSMutableArray *)section13List {
    if (!_section13List) {
        _section13List = [NSMutableArray array];
    }
    return _section13List;
}

- (NSMutableArray *)section14List {
    if (!_section14List) {
        _section14List = [NSMutableArray array];
    }
    return _section14List;
}

- (NSMutableArray *)section15List {
    if (!_section15List) {
        _section15List = [NSMutableArray array];
    }
    return _section15List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKGWBleNetworkSettingsV2Model *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKGWBleNetworkSettingsV2Model alloc] init];
    }
    return _dataModel;
}

- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.textColor = DEFAULT_TEXT_COLOR;
        _noteLabel.textAlignment = NSTextAlignmentLeft;
        _noteLabel.font = MKFont(12.f);
        _noteLabel.numberOfLines = 0;
        _noteLabel.text = noteMsg;
    }
    return _noteLabel;
}

- (UIView *)tableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 60.f)];
    footerView.backgroundColor = RGBCOLOR(242, 242, 242);
    
    [footerView addSubview:self.noteLabel];
    [self.noteLabel setHidden:YES];
    CGSize msgSize = [NSString sizeWithText:noteMsg
                                    andFont:MKFont(12.f)
                                 andMaxSize:CGSizeMake(kViewWidth - 2 * 15.f, MAXFLOAT)];
    [self.noteLabel setFrame:CGRectMake(15.f, 15.f, kViewWidth - 2 * 15.f, msgSize.height)];
    
    return footerView;
}

@end
