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
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'BleBaseController' do |sss|
      
      sss.source_files = 'MKGatewayThree/Classes/Expand/BleBaseController/**'
    
    
      sss.dependency 'MKGatewayThree/SDK/BLE'
    end
  
    ss.subspec 'BaseController' do |sss|
      
      sss.source_files = 'MKGatewayThree/Classes/Expand/BaseController/**'
    
    
      sss.dependency 'MKGatewayThree/SDK/MQTT'
      sss.dependency 'MKGatewayThree/DeviceModel'
    end
    
    ss.subspec 'DatabaseManager' do |sss|
      
      sss.source_files = 'MKGatewayThree/Classes/Expand/DatabaseManager/**'
    
    
      sss.dependency 'FMDB'
      sss.dependency 'MKGatewayThree/DeviceModel'
    end
    
    ss.subspec 'ExcelManager' do |sss|
      
      sss.source_files = 'MKGatewayThree/Classes/Expand/ExcelManager/**'
    
    
      sss.dependency 'libxlsxwriter'
      sss.dependency 'SSZipArchive'
    end
    
    ss.subspec 'View' do |sss|
      sss.subspec 'AlertView' do |ssss|
        ssss.source_files = 'MKGatewayThree/Classes/Expand/View/AlertView/**'
      end
      
      sss.subspec 'FilterCell' do |ssss|
        
        ssss.subspec 'FilterBeaconCell' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Expand/View/FilterCell/FilterBeaconCell/**'
        end
        
        ssss.subspec 'FilterByRawDataCell' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Expand/View/FilterCell/FilterByRawDataCell/**'
        end
        
        ssss.subspec 'FilterEditSectionHeaderView' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Expand/View/FilterCell/FilterEditSectionHeaderView/**'
        end
        
        ssss.subspec 'FilterNormalTextFieldCell' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Expand/View/FilterCell/FilterNormalTextFieldCell/**'
        end
      
      end
      
      sss.subspec 'UserCredentialsView' do |ssss|
        
        ssss.source_files = 'MKGatewayThree/Classes/Expand/View/UserCredentialsView/**'
        
      end
        
    end
    
    ss.subspec 'ImportServerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKGatewayThree/Classes/Expand/ImportServerPage/Controller/**'
      end
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  
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
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AddDeviceModules' do |sss|
        sss.subspec 'ParamsModel'  do |ssss|
            ssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/ParamsModel/**'
        end
        sss.subspec 'Pages' do |ssss|
          
          ssss.subspec 'BleAdvBeaconPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleAdvBeaconPage/Controller/**'
                
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleAdvBeaconPage/Model'
              end
              
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleAdvBeaconPage/Model/**'
              end
          end
          
            ssss.subspec 'BleDeviceInfoPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleDeviceInfoPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleDeviceInfoPage/Model'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleDeviceInfoPage/Model/**'
                end
            end
            
            ssss.subspec 'BleNetworkSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage/Model'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage/Model/**'
                end
            end
            
            ssss.subspec 'BleScannerFilterPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleScannerFilterPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleScannerFilterPage/Model'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleScannerFilterPage/Model/**'
                end
            end
            
            ssss.subspec 'BleWifiSettingsPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Model'
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/View'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/Model/**'
                end
                
                sssss.subspec 'View' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/BleWifiSettingsPage/View/**'
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
              
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleAdvBeaconPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleDeviceInfoPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleNetworkSettingsPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleScannerFilterPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/BleWifiSettingsPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/ConnectSuccessPage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/NTPTimezonePage'
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/ServerForDevice'
              end
            end
            
            ssss.subspec 'NTPTimezonePage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/NTPTimezonePage/Controller/**'
                
                ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/NTPTimezonePage/Model'
              end
              
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/NTPTimezonePage/Model/**'
              end
            end
            
            ssss.subspec 'ServerForDevice' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/ServerForDevice/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/ServerForDevice/Model'
                  ssssss.dependency 'MKGatewayThree/Functions/AddDeviceModules/Pages/ServerForDevice/View'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/ServerForDevice/Model/**'
                end
                
                sssss.subspec 'View' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/AddDeviceModules/Pages/ServerForDevice/View/**'
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
          ssss.dependency 'MKGatewayThree/Functions/ManageBleModules'
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
      
      sss.subspec 'DuplicateDataFilterPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/DuplicateDataFilterPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/DuplicateDataFilterPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/DuplicateDataFilterPage/Model/**'
        end
      end
          
      sss.subspec 'FilterByAdvNamePage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
            
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByAdvNamePage/Model'
              
        end
          
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByAdvNamePage/Model/**'
        end
      end
      
      sss.subspec 'FilterByBeaconPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByBeaconPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByBeaconPage/Header'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByBeaconPage/Model'
          
        end
        
        ssss.subspec 'Header' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByBeaconPage/Header/**'
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByBeaconPage/Model/**'
          
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByBeaconPage/Header'
        end
      end
      
      sss.subspec 'FilterByButtonPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByButtonPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByButtonPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByButtonPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByMacPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByMacPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByMacPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByMacPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByOtherPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByOtherPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByOtherPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByOtherPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByPirPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByPirPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByPirPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByPirPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByRawDataPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByRawDataPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByRawDataPage/Model'
          
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByBeaconPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByUIDPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByURLPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByTLMPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByButtonPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByTag'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByPirPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByOtherPage'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByRawDataPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByTag' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByTag/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByTag/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByTag/Model/**'
        end
      end
      
      sss.subspec 'FilterByTLMPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByTLMPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByTLMPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByTLMPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByUIDPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByUIDPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByUIDPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByUIDPage/Model/**'
        end
      end
      
      sss.subspec 'FilterByURLPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByURLPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByURLPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/FilterByURLPage/Model/**'
        end
      end
      
      sss.subspec 'UploadDataOptionPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadDataOptionPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/UploadDataOptionPage/Model'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadDataOptionPage/Model/**'
        end
      end
      
      sss.subspec 'UploadOptionPage' do |ssss|
        ssss.subspec 'Controller' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadOptionPage/Controller/**'
        
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/UploadOptionPage/Model'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/UploadOptionPage/View'
          
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/DuplicateDataFilterPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/UploadDataOptionPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByMacPage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByAdvNamePage'
          sssss.dependency 'MKGatewayThree/Functions/FilterPages/FilterByRawDataPage'
          
        end
      
        ssss.subspec 'Model' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadOptionPage/Model/**'
        end
        
        ssss.subspec 'View' do |sssss|
          sssss.source_files = 'MKGatewayThree/Classes/Functions/FilterPages/UploadOptionPage/View/**'
        end
        
      end
      
    end
    
    ss.subspec 'ManageBleModules' do |sss|
      
      sss.subspec 'ButtonDFUPage' do |ssss|
          ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/ButtonDFUPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/ButtonDFUPage/Model'
          end
          
          ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/ButtonDFUPage/Model/**'
          end
      end
      
      sss.subspec 'BXPButtonPage' do |ssss|
          ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/BXPButtonPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/BXPButtonPage/View'
              
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/ButtonDFUPage'
          end
          ssss.subspec 'View' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/BXPButtonPage/View/**'
          end
      end
      
      sss.subspec 'ManageBleDevicesPage' do |ssss|
          ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/ManageBleDevicesPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/ManageBleDevicesPage/View'
              
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/BXPButtonPage'
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/NormalConnectedPage'
          end
          
          ssss.subspec 'View' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/ManageBleDevicesPage/View/**'
          end
      end
      
      sss.subspec 'NormalConnectedPage' do |ssss|
          ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/NormalConnectedPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/ManageBleModules/NormalConnectedPage/View'
          end
          
          ssss.subspec 'View' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/ManageBleModules/NormalConnectedPage/View/**'
          end
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
          ssss.dependency 'MKGatewayThree/Functions/ServerForApp/View'
        end
        
        sss.subspec 'Model' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ServerForApp/Model/**'
        end
        
        sss.subspec 'View' do |ssss|
          ssss.source_files = 'MKGatewayThree/Classes/Functions/ServerForApp/View/**'
        end
    end
    
    ss.subspec 'SettingPages' do |sss|
        sss.subspec 'DeviceInfoPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
                sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/DeviceInfoPage/Controller/**'
                sssss.dependency 'MKGatewayThree/Functions/SettingPages/DeviceInfoPage/Model'
            end
            ssss.subspec 'Model' do |sssss|
                sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/DeviceInfoPage/Model/**'
            end
        end
        
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
            
            ssss.subspec 'MqttParamsListPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttParamsListPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttParamsListPage/Model'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttNetworkSettingsPage'
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttServerPage'
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttWifiSettingsPage'
                end
                
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttParamsListPage/Model/**'
                end
            end
            
            ssss.subspec 'MqttServerPage' do |sssss|
                sssss.subspec 'Controller' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttServerPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttServerPage/Model'
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages/MqttServerPage/View'
                end
                sssss.subspec 'Model' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttServerPage/Model/**'
                end
                sssss.subspec 'View' do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/ModifyNetworkPages/MqttServerPage/View/**'
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
        
        sss.subspec 'NormalSettings' do |ssss|
          
          ssss.subspec 'AdvBeaconPage' do |sssss|
              sssss.subspec 'Controller'  do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/AdvBeaconPage/Controller/**'
                
                ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/AdvBeaconPage/Model'
              end
              sssss.subspec 'Model'  do |ssssss|
                ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/AdvBeaconPage/Model/**'
              end
          end
          
            ssss.subspec 'CommunicatePage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/CommunicatePage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/CommunicatePage/Model'
                end
                sssss.subspec 'Model'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/CommunicatePage/Model/**'
                end
            end
            
            ssss.subspec 'DataReportPage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/DataReportPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/DataReportPage/Model'
                end
                sssss.subspec 'Model'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/DataReportPage/Model/**'
                end
            end
            
            ssss.subspec 'IndicatorSettingsPage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/IndicatorSettingsPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/IndicatorSettingsPage/Model'
                end
                sssss.subspec 'Model'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/IndicatorSettingsPage/Model/**'
                end
            end
            
            ssss.subspec 'NetworkStatusPage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/NetworkStatusPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/NetworkStatusPage/Model'
                end
                sssss.subspec 'Model'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/NetworkStatusPage/Model/**'
                end
            end
            
            ssss.subspec 'NTPServerPage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/NTPServerPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/NTPServerPage/Model'
                end
                sssss.subspec 'Model'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/NTPServerPage/Model/**'
                end
            end
            
            ssss.subspec 'ReconnectTimePage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/ReconnectTimePage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/ReconnectTimePage/Model'
                end
                sssss.subspec 'Model'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/ReconnectTimePage/Model/**'
                end
            end
            
            ssss.subspec 'ResetByButtonPage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/ResetByButtonPage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/ResetByButtonPage/View'
                end
                sssss.subspec 'View'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/ResetByButtonPage/View/**'
                end
            end
            
            ssss.subspec 'SystemTimePage' do |sssss|
                sssss.subspec 'Controller'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/SystemTimePage/Controller/**'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/SystemTimePage/View'
                  
                  ssssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings/NTPServerPage'
                end
                sssss.subspec 'View'  do |ssssss|
                  ssssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/NormalSettings/SystemTimePage/View/**'
                end
            end
            
        end
        
        sss.subspec 'OTAPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/OTAPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/OTAPage/Model'
            end
            ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/OTAPage/Model/**'
            end
        end
        
        sss.subspec 'SettingPage' do |ssss|
            ssss.subspec 'Controller' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/SettingPage/Controller/**'
              
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/SettingPage/Model'
              
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/DeviceInfoPage'
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/ModifyNetworkPages'
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/NormalSettings'
              sssss.dependency 'MKGatewayThree/Functions/SettingPages/OTAPage'
            end
            ssss.subspec 'Model' do |sssss|
              sssss.source_files = 'MKGatewayThree/Classes/Functions/SettingPages/SettingPage/Model/**'
            end
        end
        
    end
    
    ss.dependency 'MKGatewayThree/SDK'
    ss.dependency 'MKGatewayThree/Expand'
    ss.dependency 'MKGatewayThree/CTMediator'
    ss.dependency 'MKGatewayThree/DeviceModel'
    ss.dependency 'MKGatewayThree/CTMediator'
  
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    
    ss.dependency 'MLInputDodger'
    
  end
  
end
