#
# Be sure to run `pod lib lint MKGatewayThree.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKGatewayThree'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKGatewayThree.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/aadyx2007@163.com/MKGatewayThree'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aadyx2007@163.com' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/aadyx2007@163.com/MKGatewayThree.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKGatewayThree' => ['MKGatewayThree/Assets/*.png']
  }
  
  s.subspec 'Target' do |ss|
    
    ss.source_files = 'MKGatewayThree/Classes/Target/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKGatewayThree/Functions'
  
  end
  
  s.subspec 'CTMediator' do |ss|
    
    ss.source_files = 'MKGatewayThree/Classes/CTMediator/**'
    
    ss.dependency 'CTMediator'
    ss.dependency 'MKBaseModuleLibrary'
  
  end
  
  s.subspec 'DeviceModel' do |ss|
    
    ss.source_files = 'MKGatewayThree/Classes/DeviceModel/**'

    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKGatewayThree/SDK/MQTT'
  
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.source_files = 'MKGatewayThree/Classes/DatabaseManager/**'
  
  
    ss.dependency 'FMDB'
    ss.dependency 'MKGatewayThree/DeviceModel'
    ss.dependency 'MKBaseModuleLibrary'
    
  end
  
  s.subspec 'SDK' do |ss|
      
    ss.subspec 'BLE' do |sss|
      sss.source_files = 'MKGatewayThree/Classes/SDK/BLE/**'
      
      sss.dependency 'MKBaseBleModule'
    end
    
    ss.subspec 'MQTT' do |sss|
        sss.subspec 'Manager' do |ssss|
            ssss.source_files = 'MKGatewayThree/Classes/SDK/MQTT/Manager/**'
            
            ssss.dependency 'MKBaseModuleLibrary'
            ssss.dependency 'MKBaseMQTTModule'
        end
        
        sss.subspec 'SDK' do |ssss|
            ssss.source_files = 'MKGatewayThree/Classes/SDK/MQTT/SDK/**'
            
            ssss.dependency 'MKBaseModuleLibrary'
            ssss.dependency 'MKGatewayThree/SDK/MQTT/Manager'
        end
    end
    
  end
  
  s.subspec 'LoginManager' do |ss|
    ss.source_files = 'MKGatewayThree/Classes/LoginManager/**'
  
    ss.dependency 'MKIotCloudManager'
  end
  
  s.subspec 'ScannerModuleManager' do |ss|
    ss.source_files = 'MKGatewayThree/Classes/ScannerModuleManager/**'
    
    ss.dependency 'MKScannerCommonModule'
    
    ss.dependency 'MKGatewayThree/SDK/MQTT'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AddDeviceModules' do |sss|
        sss.subspec 'ParamsModel'  do |ssss|
            ssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/ParamsModel/**'
        end
        sss.subspec 'Pages' do |ssss|
            
            ssss.subspec 'BleNetworkSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage/Model'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage/Model/**'
                end
            end
            
            ssss.subspec 'BleNetworkSettingsV2Page' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsV2Page/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsV2Page/Model'
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsV2Page/View'
                  
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsV2Page/Model/**'
                end
                
                sssss.subspec 'View' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsV2Page/View/**'
                end
            end
            
            ssss.subspec 'BleWifiSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Model'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Model/**'
                end
            end
            
            ssss.subspec 'ConnectSuccessPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/ConnectSuccessPage/Controller/**'
                end
            end
            
            ssss.subspec 'DeviceParamsListPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/DeviceParamsListPage/Controller/**'
                
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/DeviceParamsListPage/Model'
              
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsV2Page'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleWifiSettingsPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/ConnectSuccessPage'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/DeviceParamsListPage/Model/**'
              end
            end
            
            ssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/ParamsModel'
            
        end
        
    end
    
    ss.subspec 'DeviceDataPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/DeviceDataPage/Controller/**'
          
          ssss.dependency 'MKGatewayThree/Functions/DeviceDataPage/View'
          
          ssss.dependency 'MKGatewayThree/Functions/SettingPages'
          ssss.dependency 'MKGatewayThree/Functions/FilterPages/UploadOptionPage'
          ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/DeviceDataPage/View/**'
        end
    end
    
    ss.subspec 'DeviceListPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/DeviceListPage/Controller/**'
          
          ssss.dependency 'MKGatewayThree/Functions/DeviceListPage/View'
          ssss.dependency 'MKGatewayThree/Functions/DeviceListPage/Model'
          
          ssss.dependency 'MKGatewayThree/Functions/ServerForApp'
          ssss.dependency 'MKGatewayThree/Functions/ScanPage'
          ssss.dependency 'MKGatewayThree/Functions/DeviceDataPage'
          ssss.dependency 'MKGatewayThree/Functions/SyncDevicePage'
          
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/DeviceListPage/Model/**'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/DeviceListPage/View/**'
          
          ssss.dependency 'MKGatewayThree/Functions/DeviceListPage/Model'
        end
    end
    
    ss.subspec 'FilterPages' do |sss|
      
      sss.subspec 'FilterByRawDataPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByRawDataPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByRawDataPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByRawDataPage/Model/**'
        end
      end
      
      sss.subspec 'UploadOptionPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadOptionPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/UploadOptionPage/Model'
          
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByRawDataPage'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadOptionPage/Model/**'
        end
        
      end
      
    end
    
    ss.subspec 'ManageBleDevicesPage' do |sss|
      sss.subspec 'Manager' do |ssss|
        ssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Manager/**'
      end
      sss.subspec 'Adopter' do |ssss|
        ssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Adopter/**'
        
        ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Manager'
        ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model'
      end
      
      sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Controller/**'
          
          ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model'
          ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Manager'
          ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Adopter'
          
      end
        
        sss.subspec 'Model' do |ssss|
          
          ssss.subspec 'DFU' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/DFU/**'
          end
          
          ssss.subspec 'BXPBCR' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/BXPBCR/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPBD' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/BXPBD/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPC' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/BXPC/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPD' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/BXPD/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPS' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/BXPS/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'BXPT' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/BXPT/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'Pir' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/Pir/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'Tof' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/Tof/**'
            
            sssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Model/DFU'
          end
          
          ssss.subspec 'NormalConnected' do |sssss|
            sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleDevicesPage/Model/NormalConnected/**'
          end
          
          ssss.dependency 'MKGatewayThree/Functions/ManageBleDevicesPage/Manager'
        end
    end
    
    ss.subspec 'ScanPage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ScanPage/Controller/**'
          
          ssss.dependency 'MKGatewayThree/Functions/ScanPage/Model'
          ssss.dependency 'MKGatewayThree/Functions/ScanPage/View'
          
          ssss.dependency 'MKGatewayThree/Functions/AddDeviceModules'
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ScanPage/Model/**'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ScanPage/View/**'
          
          ssss.dependency 'MKGatewayThree/Functions/ScanPage/Model'
        end
    end
    
    ss.subspec 'ServerForApp' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ServerForApp/Controller/**'
          
          ssss.dependency 'MKGatewayThree/Functions/ServerForApp/Model'
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ServerForApp/Model/**'
        end
        
    end
    
    ss.subspec 'SettingPages' do |sss|
        
        sss.subspec 'ModifyNetworkPages' do |ssss|
          
            ssss.subspec 'MqttNetworkSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsPage/Model'
                end
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsPage/Model/**'
                end
            end
            
            ssss.subspec 'MqttNetworkSettingsV2Page' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsV2Page/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsV2Page/Model'
                end
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsV2Page/Model/**'
                end
            end
            
            ssss.subspec 'MqttParamsListPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttParamsListPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttParamsListPage/Model'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsPage'

                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttWifiSettingsPage'
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsV2Page'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttParamsListPage/Model/**'
                end
            end
            
            ssss.subspec 'MqttWifiSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttWifiSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttWifiSettingsPage/Model'
                end
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttWifiSettingsPage/Model/**'
                end
            end
            
        end
        
        sss.subspec 'IndicatorSettingsPage' do |ssss|
            ssss.subspec 'Controller'  do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/IndicatorSettingsPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/IndicatorSettingsPage/Model'
            end
            ssss.subspec 'Model'  do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/IndicatorSettingsPage/Model/**'
            end
        end
        
        sss.subspec 'SettingPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/SettingPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/SettingPage/Model'
              
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages'
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/IndicatorSettingsPage'
            end
            ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/SettingPage/Model/**'
            end
        end
        
    end
    
    ss.subspec 'SyncDevicePage' do |sss|
        sss.subspec 'Controller' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/SyncDevicePage/Controller/**'
          
          ssss.dependency 'MKGatewayThree/Functions/SyncDevicePage/View'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/SyncDevicePage/View/**'
        end
    end
    
    ss.dependency 'MKGatewayThree/SDK'
    ss.dependency 'MKGatewayThree/DatabaseManager'
    ss.dependency 'MKGatewayThree/CTMediator'
    ss.dependency 'MKGatewayThree/DeviceModel'
    ss.dependency 'MKGatewayThree/CTMediator'
    ss.dependency 'MKGatewayThree/LoginManager'
    ss.dependency 'MKGatewayThree/ScannerModuleManager'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKScannerCommonModule'
    
    ss.dependency 'MLInputDodger'
    
  end
  
end
