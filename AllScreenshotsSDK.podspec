Pod::Spec.new do |s|
  s.name = 'AllScreenshotsSDK'
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '13.0'
  s.watchos.deployment_target = '6.0'
  s.version = '2.0.0'
  s.source = { :git => 'https://github.com/allscreenshots/allscreenshots-sdk-swift.git', :tag => "v#{s.version}" }
  s.authors = { 'Allscreenshots' => 'support@allscreenshots.com' }
  s.license = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.homepage = 'https://allscreenshots.com'
  s.summary = 'Official Swift SDK for the Allscreenshots screenshot API'
  s.documentation_url = 'https://docs.allscreenshots.com'
  s.source_files = 'Sources/AllScreenshotsSDK/**/*.swift'
end
