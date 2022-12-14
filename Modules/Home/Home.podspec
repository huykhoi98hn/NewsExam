#
# Be sure to run `pod lib lint Home.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Home'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Home.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/khoi.nguyen@savvycomsoftware.com/Home'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'khoi.nguyen' => 'khoi.nguyen@savvycomsoftware.com' }
  s.source           = { :git => 'https://github.com/khoi.nguyen@savvycomsoftware.com/Home.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'Home/Classes/**/*'
  
  s.dependency 'Common'
  s.dependency 'RxSwift', '6.5.0'
  s.dependency 'RxCocoa', '6.5.0'
  s.dependency 'Network'
  s.dependency 'SnapKit', '5.6.0'
  s.dependency 'Kingfisher', '~> 7.0'
  s.dependency 'SkeletonView', '~> 1.0'
end
