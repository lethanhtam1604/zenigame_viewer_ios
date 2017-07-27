project 'zenigame_viewer/zenigame_viewer.xcodeproj/'

platform :ios, '8.0'
# zenigame_viewer側もAcknowledgementsのメンテナンスが終わり次第、コメントを外す。
# post_install do | installer |
#   require 'fileutils'
#     FileUtils.cp_r('Pods/Target Support Files/Pods-zenigame/Pods-zenigame-acknowledgements.plist', 'zenigame/zenigame/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
# end
target 'zenigame_viewer' do
  use_frameworks!
  pod 'SwiftLint', '~> 0.18.0'
  pod 'PureLayout'
  pod 'Kingfisher', '~> 3.0'
  pod 'Alamofire', '~> 4.4'
  pod 'OHHTTPStubs/Swift'
  pod 'ObjectMapper', '~> 2.2'
  pod 'FontAwesomeKit'

  target 'zenigame_viewerTests' do
    inherit! :search_paths
  end

  target 'zenigame_viewerUITests' do
    inherit! :search_paths
  end

end
