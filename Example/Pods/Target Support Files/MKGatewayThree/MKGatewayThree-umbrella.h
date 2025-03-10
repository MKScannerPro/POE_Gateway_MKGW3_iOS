#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CTMediator+MKGWAdd.h"
#import "MKGWDeviceModel.h"
#import "MKGWDeviceModeManager.h"
#import "MKGWBaseViewController.h"
#import "MKGWBleBaseController.h"
#import "MKGWDeviceDatabaseManager.h"
#import "MKGWExcelDataManager.h"
#import "MKGWExcelProtocol.h"
#import "MKGWImportServerController.h"
#import "MKGWAdvNormalCell.h"
#import "MKGWAdvTriggerCell.h"
#import "MKGWAdvTriggerTwoStateCell.h"
#import "MKGWAlertView.h"
#import "MKGWBXPAdvParamsCell.h"
#import "MKGWBXPButtonAccHeaderView.h"
#import "MKGWBleWifiSettingsCertCell.h"
#import "MKGWButtonFirmwareCell.h"
#import "MKGWFilterCell.h"
#import "MKGWPressEventCountCell.h"
#import "MKGWRemoteReminderCell.h"
#import "MKGWUserCredentialsView.h"
#import "MKGWBleAdvBeaconController.h"
#import "MKGWBleAdvBeaconModel.h"
#import "MKGWBleAdvBeaconV2Controller.h"
#import "MKGWBleAdvBeaconV2Model.h"
#import "MKGWBleDeviceInfoController.h"
#import "MKGWBleDeviceInfoModel.h"
#import "MKGWBleDeviceInfoV2Controller.h"
#import "MKGWBleDeviceInfoV2Model.h"
#import "MKGWBleNetworkSettingsController.h"
#import "MKGWBleNetworkSettingsModel.h"
#import "MKGWBleNetworkSettingsV2Controller.h"
#import "MKGWBleNetworkSettingsV2Model.h"
#import "MKGWNetworkSsidSettingsCell.h"
#import "MKGWBleScannerFilterController.h"
#import "MKGWBleScannerFilterModel.h"
#import "MKGWBleWifiSettingsController.h"
#import "MKGWBleWifiSettingsModel.h"
#import "MKGWConnectSuccessController.h"
#import "MKGWDeviceParamsListController.h"
#import "MKGWDeviceParamsListV2Controller.h"
#import "MKGWBleNTPTimezoneController.h"
#import "MKGWBleNTPTimezoneModel.h"
#import "MKGWNearbyWifiController.h"
#import "MKGWNearbyWifiCell.h"
#import "MKGWServerForDeviceController.h"
#import "MKGWServerForDeviceModel.h"
#import "MKGWMQTTLWTForDeviceView.h"
#import "MKGWMQTTSSLForDeviceView.h"
#import "MKGWServerConfigDeviceFooterView.h"
#import "MKGWServerConfigDeviceSettingView.h"
#import "MKGWDeviceMQTTParamsModel.h"
#import "MKGWDeviceDataController.h"
#import "MKGWDeviceDataPageCell.h"
#import "MKGWDeviceDataPageHeaderView.h"
#import "MKGWFilterTestAlert.h"
#import "MKGWFilterTestResultAlert.h"
#import "MKGWDeviceListController.h"
#import "MKGWDeviceListModel.h"
#import "MKGWAddDeviceView.h"
#import "MKGWDeviceListCell.h"
#import "MKGWEasyShowView.h"
#import "MKGWDataUploadIntervalController.h"
#import "MKGWDataUploadIntervalModel.h"
#import "MKGWDuplicateDataFilterController.h"
#import "MKGWDuplicateDataFilterModel.h"
#import "MKGWFilterByAdvNameController.h"
#import "MKGWFilterByAdvNameModel.h"
#import "MKGWFilterByBeaconController.h"
#import "MKGWFilterByBeaconDefines.h"
#import "MKGWFilterByBeaconModel.h"
#import "MKGWFilterByButtonController.h"
#import "MKGWFilterByButtonModel.h"
#import "MKGWFilterByMacController.h"
#import "MKGWFilterByMacModel.h"
#import "MKGWFilterByOtherController.h"
#import "MKGWFilterByOtherModel.h"
#import "MKGWFilterByPirController.h"
#import "MKGWFilterByPirModel.h"
#import "MKGWFilterByRawDataController.h"
#import "MKGWFilterByRawDataModel.h"
#import "MKGWFilterByRawDataV2Controller.h"
#import "MKGWFilterByRawDataV2Model.h"
#import "MKGWFilterByTLMController.h"
#import "MKGWFilterByTLMModel.h"
#import "MKGWFilterByTagController.h"
#import "MKGWFilterByTagModel.h"
#import "MKGWFilterByTofController.h"
#import "MKGWFilterByTofModel.h"
#import "MKGWFilterByUIDController.h"
#import "MKGWFilterByUIDModel.h"
#import "MKGWFilterByURLController.h"
#import "MKGWFilterByURLModel.h"
#import "MKGWUploadDataOptionController.h"
#import "MKGWUploadDataOptionModel.h"
#import "MKGWUploadOptionController.h"
#import "MKGWUploadOptionModel.h"
#import "MKGWUploadOptionV2Controller.h"
#import "MKGWUploadOptionV2Model.h"
#import "MKGWBXPButtonCRAccDataController.h"
#import "MKGWBXPButtonCRAdvParamsController.h"
#import "MKGWBXPButtonCRAdvParamsModel.h"
#import "MKGWBXPButtonCRController.h"
#import "MKGWBXPButtonCRRemoteReminderController.h"
#import "MKGWBXPButtonCRRemoteReminderModel.h"
#import "MKGWBXPButtonAccDataController.h"
#import "MKGWBXPButtonAdvParamsController.h"
#import "MKGWBXPButtonAdvParamsModel.h"
#import "MKGWBXPButtonController.h"
#import "MKGWBXPButtonRemoteReminderController.h"
#import "MKGWBXPButtonRemoteReminderModel.h"
#import "MKGWBXPCAccelerometerController.h"
#import "MKGWBXPCAdvParamsController.h"
#import "MKGWCAdvParamsModel.h"
#import "MKGWBXPCHistoricalTHDataController.h"
#import "MKGWBXPCHistoricalTHDataHeaderView.h"
#import "MKGWBXPCController.h"
#import "MKGWBXPCRealTimeTHDataController.h"
#import "MKGWBXPCTHDataSampleRateController.h"
#import "MKGWBXPCTHDataSampleRateModel.h"
#import "MKGWBXPDAccelerometerController.h"
#import "MKGWBXPDAccParamsController.h"
#import "MKGWBXPDAccParamsModel.h"
#import "MKGWBXPDAdvParamsController.h"
#import "MKGWDAdvParamsModel.h"
#import "MKGWBXPDController.h"
#import "MKGWBXPSAccelerometerController.h"
#import "MKGWBXPSAdvParamsController.h"
#import "MKGWBXPSAdvParamsModel.h"
#import "MKGWBXPSAdvNormalCell.h"
#import "MKGWBXPSAdvTriggerCell.h"
#import "MKGWBXPSAdvTriggerTwoStateCell.h"
#import "MKGWBXPSHallCountController.h"
#import "MKGWBXPSHistoricalTHDataController.h"
#import "MKGWBXPSHistoricalTHDataHeaderView.h"
#import "MKGWBXPSController.h"
#import "MKGWBXPSRealTimeTHDataController.h"
#import "MKGWBXPSRemoteReminderController.h"
#import "MKGWBXPSRemoteReminderModel.h"
#import "MKGWBXPSTHDataSampleRateController.h"
#import "MKGWBXPSTHDataSampleRateModel.h"
#import "MKGWBXPTAccelerometerController.h"
#import "MKGWBXPTAccParamsController.h"
#import "MKGWBXPTAccParamsModel.h"
#import "MKGWBXPTAdvParamsController.h"
#import "MKGWTAdvParamsModel.h"
#import "MKGWBXPTMotionEventController.h"
#import "MKGWBXPTController.h"
#import "MKGWBXPTRemoteReminderController.h"
#import "MKGWBXPTRemoteReminderModel.h"
#import "MKGWButtonDFUController.h"
#import "MKGWButtonDFUModel.h"
#import "MKGWTofAccelerometerController.h"
#import "MKGWTofAdvParamsController.h"
#import "MKGWTofAdvParamsModel.h"
#import "MKGWTofController.h"
#import "MKGWTofSensorDataController.h"
#import "MKGWTofSensorParamsController.h"
#import "MKGWTofSensorParamsModel.h"
#import "MKGWManageBleDevicesController.h"
#import "MKGWManageBleDevicesCell.h"
#import "MKGWManageBleDeviceSearchView.h"
#import "MKGWManageBleDevicesSearchButton.h"
#import "MKGWManageBleDevicesTypeSelectedCell.h"
#import "MKGWManageBleDevicesTypeSelectedView.h"
#import "MKGWNormalConnectedController.h"
#import "MKGWConnectedDeviceWriteAlertView.h"
#import "MKGWNormalConnectedCell.h"
#import "MKGWPirAdvParamsController.h"
#import "MKGWPirAdvParamsModel.h"
#import "MKGWPirController.h"
#import "MKGWPirSensorDataController.h"
#import "MKGWPirSensorParamsController.h"
#import "MKGWPirSensorParamsModel.h"
#import "MKGWScanPageController.h"
#import "MKGWScanPageModel.h"
#import "MKGWScanPageCell.h"
#import "MKGWServerForAppController.h"
#import "MKGWServerForAppModel.h"
#import "MKGWMQTTSSLForAppView.h"
#import "MKGWServerConfigAppFooterView.h"
#import "MKGWDeviceInfoController.h"
#import "MKGWDeviceInfoModel.h"
#import "MKGWMqttNetworkSettingsController.h"
#import "MKGWMqttNetworkSettingsModel.h"
#import "MKGWMqttNetworkSettingsV2Controller.h"
#import "MKGWMqttNetworkSettingsV2Model.h"
#import "MKGWMqttParamsListController.h"
#import "MKGWMqttParamsModel.h"
#import "MKGWMqttServerController.h"
#import "MKGWMqttServerModel.h"
#import "MKGWMqttServerConfigFooterView.h"
#import "MKGWMqttServerLwtView.h"
#import "MKGWMqttServerSettingView.h"
#import "MKGWMqttServerSSLTextField.h"
#import "MKGWMqttServerSSLView.h"
#import "MKGWMqttWifiSettingsController.h"
#import "MKGWMqttWifiSettingsModel.h"
#import "MKGWAdvBeaconController.h"
#import "MKGWAdvBeaconModel.h"
#import "MKGWAdvBeaconV2Controller.h"
#import "MKGWAdvBeaconV2Model.h"
#import "MKGWCommunicateController.h"
#import "MKGWCommunicateModel.h"
#import "MKGWDataReportController.h"
#import "MKGWDataReportModel.h"
#import "MKGWIndicatorSettingsController.h"
#import "MKGWIndicatorSetingsModel.h"
#import "MKGWNTPServerController.h"
#import "MKGWNTPServerModel.h"
#import "MKGWNetworkStatusController.h"
#import "MKGWNetworkStatusModel.h"
#import "MKGWReconnectTimeController.h"
#import "MKGWReconnectTimeModel.h"
#import "MKGWResetByButtonController.h"
#import "MKGWResetByButtonCell.h"
#import "MKGWSystemTimeController.h"
#import "MKGWSystemTimeCell.h"
#import "MKGWOTAController.h"
#import "MKGWOTAPageModel.h"
#import "MKGWSettingController.h"
#import "MKGWSettingForV2Controller.h"
#import "MKGWSettingModel.h"
#import "MKGWSyncDeviceController.h"
#import "MKGWSyncDeviceCell.h"
#import "MKGWUserLoginManager.h"
#import "CBPeripheral+MKGWAdd.h"
#import "MKGWBLESDK.h"
#import "MKGWCentralManager.h"
#import "MKGWInterface+MKGWConfig.h"
#import "MKGWInterface.h"
#import "MKGWOperation.h"
#import "MKGWOperationID.h"
#import "MKGWPeripheral.h"
#import "MKGWSDKDataAdopter.h"
#import "MKGWSDKNormalDefines.h"
#import "MKGWTaskAdopter.h"
#import "MKGWMQTTServerManager.h"
#import "MKGWServerConfigDefines.h"
#import "MKGWServerParamsModel.h"
#import "MKGWMQTTConfigDefines.h"
#import "MKGWMQTTDataManager.h"
#import "MKGWMQTTInterface.h"
#import "MKGWMQTTOperation.h"
#import "MKGWMQTTTaskAdopter.h"
#import "MKGWMQTTTaskID.h"
#import "Target_ScannerPro_GW3_Module.h"

FOUNDATION_EXPORT double MKGatewayThreeVersionNumber;
FOUNDATION_EXPORT const unsigned char MKGatewayThreeVersionString[];

