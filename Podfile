# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
target 'WhatsBumpin' do
  # Uncomment this line if you're using Swift or would like to use dynamic frameworks
  
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'
  pod 'pop'
  pod 'Shimmer'
  pod 'FBSDKLoginKit'

  target 'WhatsBumpinTests' do
      #inherit! :search_paths
    pod 'Expecta', '~> 1.0'
    # Pods for testing
  end

  target 'WhatsBumpinUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '2.3'  ## or '3.0'
          end
      end
  end


end
