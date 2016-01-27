source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
inhibit_all_warnings!

xcodeproj 'Questions'

target :Questions do

pod 'PureLayout', '~> 2.0'
pod 'AFNetworking', '~> 2.5'
pod 'MBProgressHUD', '~> 0.4'
pod 'JSONModel', '~> 1.0'
pod 'SignatureView'
pod 'MZFormSheetController'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
  end
end