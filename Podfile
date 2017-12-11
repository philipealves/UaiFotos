# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Uai Fotos' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UaiTreino

pod 'BFKit-Swift'
pod 'IQKeyboardManagerSwift', '5.0.0'
#pod 'Alamofire', '~> 4.5'
#pod 'Genome', '~> 3.2.1'
pod 'Eureka', '~> 4.0.1'
pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
pod 'Kingfisher', '~> 4.5.0'
pod 'Hero', '~> 1.0.1'
pod 'SwiftyAvatar', '~> 1.1'
pod 'SwiftMessages'
pod 'SVPullToRefresh'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'RxSwift',    '~> 4.0'
#pod 'RxCocoa',    '~> 4.0'
pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
pod  'SwiftRandom'
pod 'AlamofireObjectMapper', '~> 5.0'
pod 'RxAlamofire'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        compatibility_pods = ['Genome']
        if compatibility_pods.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
