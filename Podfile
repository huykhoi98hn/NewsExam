workspace 'NewsExam.xcworkspace'
project 'NewsExam.xcodeproj'

def development_pod
  pod 'Home', :path => 'Modules/Home'
  pod 'Common', :path => 'Modules/Common'
  pod 'Network', :path => 'Modules/Network'
end

target 'NewsExam' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NewsAssignment
  development_pod
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'SnapKit', '5.6.0'
  pod 'Kingfisher', '~> 7.0'
  pod 'SkeletonView', '~> 1.0'
end
