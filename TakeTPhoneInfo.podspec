#
# Be sure to run `pod lib lint TakeTPhoneInfo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TakeTPhoneInfo'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TakeTPhoneInfo.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Add extra info getter for LFPhoneInfo, Why make a new pod? because podspec can't use `:git` in s.dependency, so I can't just use the modifier version in my repo. so here is make a new pod.
                       DESC

  s.homepage         = 'https://github.com/takeTrace/TakeTPhoneInfo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'takeTrace' => 'takeTrace00@gmail.com' }
  s.source           = { :git => 'https://github.com/takeTrace/TakeTPhoneInfo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TakeTPhoneInfo/Classes/**/*'
  
  # s.resource_bundles = {
  #   'TakeTPhoneInfo' => ['TakeTPhoneInfo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'LFPhoneInfo'
   s.libraries = 'resolv.9'
end
