# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NewsApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NewsApp
  pod 'RxSwift'
  pod 'RxCocoa'
  #network conntion
  pod 'Alamofire'
  #indicaror
  pod 'RappleProgressHUD'
  #connection checker
  pod 'Connectivity'
  #image loader
  pod 'SDWebImage'
  
  # set development tragets
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13'
      end
    end
  end

end
