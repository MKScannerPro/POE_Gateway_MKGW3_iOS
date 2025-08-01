
typedef NS_ENUM(NSInteger, mk_gw_keyResetType) {
    mk_gw_keyResetType_disable,           //Disable
    mk_gw_keyResetType_powerOnOneMin,     //Press in 1 min after powered
    mk_gw_keyResetType_pressAnyTime,      //Press any time
};

typedef NS_ENUM(NSInteger, mk_gw_filterRelationship) {
    mk_gw_filterRelationship_null,
    mk_gw_filterRelationship_mac,
    mk_gw_filterRelationship_advName,
    mk_gw_filterRelationship_rawData,
    mk_gw_filterRelationship_advNameAndRawData,
    mk_gw_filterRelationship_advNameAndRawDataAndMac,
    mk_gw_filterRelationship_advNameOrRawData,
    mk_gw_filterRelationship_advNameAndRawMac,
};

typedef NS_ENUM(NSInteger, mk_gw_filterByTLM) {
    mk_gw_filterByTLM_nonEncrypted,        //Non-encrypted type TLM
    mk_gw_filterByTLM_encrypted,           //Encryption type TLM
    mk_gw_filterByTLM_all,                //Filter all Eddystone_TLM data
};

typedef NS_ENUM(NSInteger, mk_gw_filterByOther) {
    mk_gw_filterByOther_A,                 //Filter by A condition.
    mk_gw_filterByOther_AB,                //Filter by A & B condition.
    mk_gw_filterByOther_AOrB,              //Filter by A | B condition.
    mk_gw_filterByOther_ABC,               //Filter by A & B & C condition.
    mk_gw_filterByOther_ABOrC,             //Filter by (A & B) | C condition.
    mk_gw_filterByOther_AOrBOrC,           //Filter by A | B | C condition.
};

typedef NS_ENUM(NSInteger, mk_gw_duplicateDataFilter) {
    mk_gw_duplicateDataFilter_none,
    mk_gw_duplicateDataFilter_mac,
    mk_gw_duplicateDataFilter_macAndDataType,
    mk_gw_duplicateDataFilter_macAndRawData
};


typedef NS_ENUM(NSInteger, mk_gw_mqtt_networkType) {
    mk_gw_mqtt_networkType_ethernet,
    mk_gw_mqtt_networkType_wifi,
    mk_gw_mqtt_networkType_ethernetAndWifi,     //Only for V2
    mk_gw_mqtt_networkType_wifiAndEthernet,     //Only for V2
};


typedef NS_ENUM(NSInteger, mk_gw_PHYMode) {
    mk_gw_PHYMode_BLE4,                     //1M PHY (BLE 4.2)
    mk_gw_PHYMode_BLE5,                     //1M PHY (BLE 5)
    mk_gw_PHYMode_BLE4AndBLE5,              //1M PHY (BLE 4.2 + BLE 5)
    mk_gw_PHYMode_CodedBLE5,                //Coded PHY(BLE 5)
};

typedef NS_ENUM(NSInteger, mk_gw_triggerEventType) {
    mk_gw_triggerEventType_singlePress,
    mk_gw_triggerEventType_DoublePress,
    mk_gw_triggerEventType_longPress,
};

typedef NS_ENUM(NSInteger, mk_gw_threeAxisDataRate) {
    mk_gw_threeAxisDataRate1hz,           //1hz
    mk_gw_threeAxisDataRate10hz,          //10hz
    mk_gw_threeAxisDataRate25hz,          //25hz
    mk_gw_threeAxisDataRate50hz,          //50hz
    mk_gw_threeAxisDataRate100hz          //100hz
};

typedef NS_ENUM(NSInteger, mk_gw_threeAxisDataAG) {
    mk_gw_threeAxisDataAG0,               //±2g
    mk_gw_threeAxisDataAG1,               //±4g
    mk_gw_threeAxisDataAG2,               //±8g
    mk_gw_threeAxisDataAG3                //±16g
};

typedef NS_ENUM(NSInteger, mk_gw_bxptLedColor) {
    mk_gw_bxptLedColor_green,
    mk_gw_bxptLedColor_blue,
    mk_gw_bxptLedColor_red
};

typedef NS_ENUM(NSInteger, mk_gw_pirSensorParamType) {
    mk_gw_pirSensorParamTypeLow,
    mk_gw_pirSensorParamTypeMedium,
    mk_gw_pirSensorParamTypeHigh,
};

typedef NS_ENUM(NSInteger, mk_gw_tofRangingMode) {
    mk_gw_tofRangingModeShortdistance,
    mk_gw_tofRangingModeLongdistance,
};

typedef NS_ENUM(NSInteger, mk_gw_bxpcrAlarmEventType) {
    mk_gw_bxpcrAlarmEventType_single,
    mk_gw_bxpcrAlarmEventType_double,
    mk_gw_bxpcrAlarmEventType_long
};

@protocol gw_indicatorLightStatusProtocol <NSObject>

@property (nonatomic, assign)BOOL system_indicator;

@property (nonatomic, assign)BOOL network_indicator;

@property (nonatomic, assign)BOOL server_indicator;

@end



@protocol mk_gw_BLEFilterRawDataProtocol <NSObject>

/// The currently filtered data type, refer to the definition of different Bluetooth data types by the International Bluetooth Organization, 1 byte of hexadecimal data
@property (nonatomic, copy)NSString *dataType;

/// Data location to start filtering.if minIndex's value is 0,maxIndex must be 0;
@property (nonatomic, assign)NSInteger minIndex;

/// Data location to end filtering.if maxIndex's value is 0,minIndex must be 0;
@property (nonatomic, assign)NSInteger maxIndex;

/// The currently filtered content. The data length should be maxIndex-minIndex, if maxIndex=0&&minIndex==0, the item length is not checked whether it meets the requirements.MAX length:29 Bytes
@property (nonatomic, copy)NSString *rawData;

@end


@protocol mk_gw_BLEFilterBXPButtonProtocol <NSObject>

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, assign)BOOL singlePressIsOn;

@property (nonatomic, assign)BOOL doublePressIsOn;

@property (nonatomic, assign)BOOL longPressIsOn;

@property (nonatomic, assign)BOOL abnormalInactivityIsOn;

@end


@protocol mk_gw_BLEFilterPirProtocol <NSObject>

@property (nonatomic, assign)BOOL isOn;

/// 0：low delay 1：medium delay 2：high delay 3：all type
@property (nonatomic, assign)NSInteger delayRespneseStatus;

/// 0：close 1：open 2：all type
@property (nonatomic, assign)NSInteger doorStatus;

/// 0：low sensitivity 1：medium sensitivity 2：high sensitivity 3：all type
@property (nonatomic, assign)NSInteger sensorSensitivity;

/// 0：no effective motion detected 1：effective motion detected 2：all type
@property (nonatomic, assign)NSInteger sensorDetectionStatus;

@end


#pragma mark - 通过MQTT重新设置设备的wifi

@protocol mk_gw_mqttModifyWifiProtocol <NSObject>

/// 0:personal  1:enterprise
@property (nonatomic, assign)NSInteger security;

/// security为enterprise的时候才有效。0:PEAP-MSCHAPV2  1:TTLS-MSCHAPV2  2:TLS
@property (nonatomic, assign)NSInteger eapType;

/// 1-32 Characters.
@property (nonatomic, copy)NSString *ssid;

/// 0-64 Characters.security为personal的时候才有效
@property (nonatomic, copy)NSString *wifiPassword;

/// 0-32 Characters.  eapType为PEAP-MSCHAPV2/TTLS-MSCHAPV2才有效
@property (nonatomic, copy)NSString *eapUserName;

/// 0-64 Characters.eapType为TLS的时候无此参数
@property (nonatomic, copy)NSString *eapPassword;

/// 0-64 Characters.eapType为TLS的时候有效
@property (nonatomic, copy)NSString *domainID;

/// eapType为PEAP-MSCHAPV2/TTLS-MSCHAPV2才有效
@property (nonatomic, assign)BOOL verifyServer;

@end

@protocol mk_gw_mqttModifyWifiEapCertProtocol <NSObject>

/// security为personal无此参数
@property (nonatomic, copy)NSString *caFilePath;

/// eapType为TLS有效
@property (nonatomic, copy)NSString *clientKeyPath;

/// eapType为TLS有效
@property (nonatomic, copy)NSString *clientCertPath;

@end



@protocol mk_gw_mqttModifyNetworkProtocol <NSObject>

@property (nonatomic, assign)BOOL dhcp;

/// 47.104.81.55
@property (nonatomic, copy)NSString *ip;

/// 47.104.81.55
@property (nonatomic, copy)NSString *mask;

/// 47.104.81.55
@property (nonatomic, copy)NSString *gateway;

/// 47.104.81.55
@property (nonatomic, copy)NSString *dns;

@end


@protocol mk_gw_modifyMqttServerProtocol <NSObject>

/// 1-64 characters
@property (nonatomic, copy)NSString *host;

/// 1-65535
@property (nonatomic, copy)NSString *port;

/// 1-64 Characters
@property (nonatomic, copy)NSString *clientID;

/// 1-128 Characters
@property (nonatomic, copy)NSString *subscribeTopic;

/// 1-128 Characters
@property (nonatomic, copy)NSString *publishTopic;

@property (nonatomic, assign)BOOL cleanSession;

/// 0/1/2
@property (nonatomic, assign)NSInteger qos;

/// 10s~120s.
@property (nonatomic, copy)NSString *keepAlive;

/// 0-256 Characters
@property (nonatomic, copy)NSString *userName;

/// 0-256 Characters
@property (nonatomic, copy)NSString *password;

/// 0:TCP    1:CA signed server certificate     2:CA certificate     3:Self signed certificates
@property (nonatomic, assign)NSInteger connectMode;

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

/// 0/1/2
@property (nonatomic, assign)NSInteger lwtQos;

/// 1-128 Characters
@property (nonatomic, copy)NSString *lwtTopic;

/// 1-128 Characters
@property (nonatomic, copy)NSString *lwtPayload;

@end


@protocol mk_gw_modifyMqttServerCertsProtocol <NSObject>

/// 0-256 Characters
@property (nonatomic, copy)NSString *caFilePath;

/// 0-256 Characters
@property (nonatomic, copy)NSString *clientKeyPath;

/// 0-256 Characters
@property (nonatomic, copy)NSString *clientCertPath;

@end


#pragma mark - 扫描数据上报内容选项protocol

@protocol gw_uploadDataOptionProtocol <NSObject>

/// V2版本固件
@property (nonatomic, assign)BOOL isV2;

@property (nonatomic, assign)BOOL timestamp;

@property (nonatomic, assign)BOOL rawData_advertising;

//V2版本固件没有此参数
@property (nonatomic, assign)BOOL rawData_response;

@end



#pragma mark - Advertise iBeacon

@protocol gw_advertiseBeaconProtocol <NSObject>

@property (nonatomic, assign)BOOL advertise;

@property (nonatomic, assign)NSInteger major;

@property (nonatomic, assign)NSInteger minor;

@property (nonatomic, copy)NSString *uuid;

@property (nonatomic, assign)NSInteger advInterval;

/*
 0：-24dbm
 1：-21dbm
 2：-18dbm
 3：-15dbm
 4：-12dbm
 5：-9dbm
 6：-6dbm
 7：-3dbm
 8：0dbm
 9：3dbm
 10：6dbm
 11：9dbm
 12：12dbm
 13：15dbm
 14：18dbm
 15：21dbm
 */
@property (nonatomic, assign)NSInteger txPower;

@end


@protocol gw_advertiseBeaconV2Protocol <gw_advertiseBeaconProtocol>

@property (nonatomic, assign)NSInteger rssi1M;

@property (nonatomic, assign)BOOL connectable;

@end
