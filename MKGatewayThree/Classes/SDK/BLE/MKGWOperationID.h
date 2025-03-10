

typedef NS_ENUM(NSInteger, mk_gw_taskOperationID) {
    mk_gw_defaultTaskOperationID,
    
#pragma mark - Read
    mk_gw_taskReadDeviceModelOperation,        //读取产品型号
    mk_gw_taskReadFirmwareOperation,           //读取固件版本
    mk_gw_taskReadHardwareOperation,           //读取硬件类型
    mk_gw_taskReadSoftwareOperation,           //读取软件版本
    mk_gw_taskReadManufacturerOperation,       //读取厂商信息
    
#pragma mark - 自定义协议读取
    mk_gw_taskReadDeviceEthernetMacAddressOperation,    //读取设备以太网MAC
    mk_gw_taskReadDeviceNameOperation,         //读取设备名称
    mk_gw_taskReadDeviceMacAddressOperation,    //读取MAC地址
    mk_gw_taskReadDeviceWifiSTAMacAddressOperation, //读取WIFI STA MAC地址
    mk_gw_taskReadNTPServerHostOperation,       //读取NTP服务器域名
    mk_gw_taskReadTimeZoneOperation,            //读取时区
    mk_gw_taskReadWifiFirmwareOperation,        //读取wifi固件版本
    mk_gw_taskReadBLEFirmwareOperation,         //读取BLE固件版本
    
#pragma mark - Wifi Params
    mk_gw_taskReadWIFISecurityOperation,        //读取设备当前wifi的加密模式
    mk_gw_taskReadWIFISSIDOperation,            //读取设备当前的wifi ssid
    mk_gw_taskReadWIFIPasswordOperation,        //读取设备当前的wifi密码
    mk_gw_taskReadWIFIEAPTypeOperation,         //读取设备当前的wifi EAP类型
    mk_gw_taskReadWIFIEAPUsernameOperation,     //读取设备当前的wifi EAP用户名
    mk_gw_taskReadWIFIEAPPasswordOperation,     //读取设备当前的wifi EAP密码
    mk_gw_taskReadWIFIEAPDomainIDOperation,     //读取设备当前的wifi EAP域名ID
    mk_gw_taskReadWIFIVerifyServerStatusOperation,  //读取是否校验服务器
    mk_gw_taskReadWIFIDHCPStatusOperation,              //读取Wifi DHCP开关
    mk_gw_taskReadWIFINetworkIpInfosOperation,          //读取Wifi IP信息
    mk_gw_taskReadNetworkTypeOperation,                 //读取网络类型
    mk_gw_taskReadEthernetDHCPStatusOperation,          //读取Ethernet DHCP开关
    mk_gw_taskReadEthernetNetworkIpInfosOperation,      //读取Ethernet IP信息
    
#pragma mark - MQTT Params
    mk_gw_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_gw_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_gw_taskReadClientIDOperation,            //读取Client ID
    mk_gw_taskReadServerUserNameOperation,      //读取服务器登录用户名
    mk_gw_taskReadServerPasswordOperation,      //读取服务器登录密码
    mk_gw_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_gw_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_gw_taskReadServerQosOperation,           //读取MQTT Qos
    mk_gw_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_gw_taskReadPublishTopicOperation,        //读取Publish topic
    mk_gw_taskReadLWTStatusOperation,           //读取LWT开关状态
    mk_gw_taskReadLWTQosOperation,              //读取LWT Qos
    mk_gw_taskReadLWTRetainOperation,           //读取LWT Retain
    mk_gw_taskReadLWTTopicOperation,            //读取LWT topic
    mk_gw_taskReadLWTPayloadOperation,          //读取LWT Payload
    mk_gw_taskReadConnectModeOperation,         //读取MQTT服务器通信加密方式
    
#pragma mark - Filter Params
    mk_gw_taskReadRssiFilterValueOperation,             //读取扫描RSSI过滤
    mk_gw_taskReadFilterRelationshipOperation,          //读取扫描过滤逻辑
    mk_gw_taskReadFilterMACAddressListOperation,        //读取MAC过滤列表
    mk_gw_taskReadFilterAdvNameListOperation,           //读取ADV Name过滤列表
    mk_gw_taskReadFilterReportIntervalOperation,        //读取数据上报间隔
    
#pragma mark - iBeacon Params
    mk_gw_taskReadAdvertiseBeaconStatusOperation,       //读取iBeacon开关
    mk_gw_taskReadBeaconMajorOperation,                 //读取iBeacon major
    mk_gw_taskReadBeaconMinorOperation,                 //读取iBeacon minor
    mk_gw_taskReadBeaconUUIDOperation,                  //读取iBeacon UUID
    mk_gw_taskReadBeaconAdvIntervalOperation,           //读取Adv interval
    mk_gw_taskReadBeaconTxPowerOperation,               //读取Tx Power
    mk_gw_taskReadBeaconRssiOperation,                      //读取RSSI@1m
    mk_gw_taskReadConnectableOperation,                 //读取可连接状态
    mk_gw_taskReadDeviceModeOperation,                  //读取设备模式
    
    
#pragma mark - 密码特征
    mk_gw_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 配置
    mk_gw_taskEnterSTAModeOperation,                //设备重启进入STA模式
    mk_gw_taskConfigNTPServerHostOperation,         //配置NTP服务器域名
    mk_gw_taskConfigTimeZoneOperation,              //配置时区
    
#pragma mark - Wifi Params
    
    mk_gw_taskConfigWIFISecurityOperation,      //配置wifi的加密模式
    mk_gw_taskConfigWIFISSIDOperation,          //配置wifi的ssid
    mk_gw_taskConfigWIFIPasswordOperation,      //配置wifi的密码
    mk_gw_taskConfigWIFIEAPTypeOperation,       //配置wifi的EAP类型
    mk_gw_taskConfigWIFIEAPUsernameOperation,   //配置wifi的EAP用户名
    mk_gw_taskConfigWIFIEAPPasswordOperation,   //配置wifi的EAP密码
    mk_gw_taskConfigWIFIEAPDomainIDOperation,   //配置wifi的EAP域名ID
    mk_gw_taskConfigWIFIVerifyServerStatusOperation,    //配置wifi是否校验服务器
    mk_gw_taskConfigWIFICAFileOperation,                //配置WIFI CA证书
    mk_gw_taskConfigWIFIClientCertOperation,            //配置WIFI设备证书
    mk_gw_taskConfigWIFIClientPrivateKeyOperation,      //配置WIFI私钥
    mk_gw_taskConfigWIFIDHCPStatusOperation,                //配置Wifi DHCP开关
    mk_gw_taskConfigWIFIIpInfoOperation,                    //配置Wifi IP地址相关信息
    mk_gw_taskConfigNetworkTypeOperation,                   //配置网络接口类型
    mk_gw_taskConfigEthernetDHCPStatusOperation,            //配置Ethernet DHCP开关
    mk_gw_taskConfigEthernetIpInfoOperation,                //配置Ethernet IP地址相关信息
    mk_gw_taskStartWifiScanOperation,                       //进行一次wifi扫描
    
#pragma mark - MQTT Params
    mk_gw_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_gw_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_gw_taskConfigClientIDOperation,              //配置ClientID
    mk_gw_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_gw_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_gw_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_gw_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_gw_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_gw_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_gw_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_gw_taskConfigLWTStatusOperation,             //配置LWT开关
    mk_gw_taskConfigLWTQosOperation,                //配置LWT Qos
    mk_gw_taskConfigLWTRetainOperation,             //配置LWT Retain
    mk_gw_taskConfigLWTTopicOperation,              //配置LWT topic
    mk_gw_taskConfigLWTPayloadOperation,            //配置LWT payload
    mk_gw_taskConfigConnectModeOperation,           //配置MQTT服务器通信加密方式
    mk_gw_taskConfigCAFileOperation,                //配置CA证书
    mk_gw_taskConfigClientCertOperation,            //配置设备证书
    mk_gw_taskConfigClientPrivateKeyOperation,      //配置私钥
        
#pragma mark - 过滤参数
    mk_gw_taskConfigRssiFilterValueOperation,                   //配置扫描RSSI过滤
    mk_gw_taskConfigFilterRelationshipOperation,                //配置扫描过滤逻辑
    mk_gw_taskConfigFilterMACAddressListOperation,           //配置MAC过滤规则
    mk_gw_taskConfigFilterAdvNameListOperation,             //配置Adv Name过滤规则
    mk_gw_taskConfigFilterReportIntervalOperation,          //配置数据上报间隔
    
#pragma mark - 蓝牙广播参数
    mk_gw_taskConfigAdvertiseBeaconStatusOperation,         //配置iBeacon开关
    mk_gw_taskConfigBeaconMajorOperation,                   //配置iBeacon major
    mk_gw_taskConfigBeaconMinorOperation,                   //配置iBeacon minor
    mk_gw_taskConfigBeaconUUIDOperation,                    //配置iBeacon UUID
    mk_gw_taskConfigAdvIntervalOperation,                   //配置广播频率
    mk_gw_taskConfigTxPowerOperation,                       //配置Tx Power
    mk_gw_taskConfigBeaconRssiOperation,                    //配置Beacon Rssi@1m
    mk_gw_taskConfigConnectableOperation,                   //配置可连接状态
};

