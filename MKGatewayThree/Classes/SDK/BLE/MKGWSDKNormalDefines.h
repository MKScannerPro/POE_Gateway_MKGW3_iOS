
typedef NS_ENUM(NSInteger, mk_gw_centralConnectStatus) {
    mk_gw_centralConnectStatusUnknow,                                           //未知状态
    mk_gw_centralConnectStatusConnecting,                                       //正在连接
    mk_gw_centralConnectStatusConnected,                                        //连接成功
    mk_gw_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_gw_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_gw_centralManagerStatus) {
    mk_gw_centralManagerStatusUnable,                           //不可用
    mk_gw_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_gw_networkType) {
    mk_gw_networkType_ethernet,
    mk_gw_networkType_wifi,
};

typedef NS_ENUM(NSInteger, mk_gw_wifiSecurity) {
    mk_gw_wifiSecurity_personal,
    mk_gw_wifiSecurity_enterprise,
};

typedef NS_ENUM(NSInteger, mk_gw_eapType) {
    mk_gw_eapType_peap_mschapv2,
    mk_gw_eapType_ttls_mschapv2,
    mk_gw_eapType_tls,
};

typedef NS_ENUM(NSInteger, mk_gw_connectMode) {
    mk_gw_connectMode_TCP,                                          //TCP
    mk_gw_connectMode_CASignedServerCertificate,                    //SSL.Do not verify the server certificate.
    mk_gw_connectMode_CACertificate,                                //SSL.Verify the server's certificate
    mk_gw_connectMode_SelfSignedCertificates,                       //SSL.Two-way authentication
};

//Quality of MQQT service
typedef NS_ENUM(NSInteger, mk_gw_mqttServerQosMode) {
    mk_gw_mqttQosLevelAtMostOnce,      //At most once. The message sender to find ways to send messages, but an accident and will not try again.
    mk_gw_mqttQosLevelAtLeastOnce,     //At least once.If the message receiver does not know or the message itself is lost, the message sender sends it again to ensure that the message receiver will receive at least one, and of course, duplicate the message.
    mk_gw_mqttQosLevelExactlyOnce,     //Exactly once.Ensuring this semantics will reduce concurrency or increase latency, but level 2 is most appropriate when losing or duplicating messages is unacceptable.
};

typedef NS_ENUM(NSInteger, mk_gw_filterRelationship) {
    mk_gw_filterRelationship_null,
    mk_gw_filterRelationship_mac,
    mk_gw_filterRelationship_advName,
    mk_gw_filterRelationship_rawData,
    mk_gw_filterRelationship_advNameAndRawData,
    mk_gw_filterRelationship_macAndadvNameAndRawData,
    mk_gw_filterRelationship_advNameOrRawData,
    mk_gw_filterRelationship_advNameAndMacData,
};


@protocol mk_gw_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param deviceModel device
- (void)mk_gw_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_gw_startScan;

/// Stops scanning equipment.
- (void)mk_gw_stopScan;

@end
