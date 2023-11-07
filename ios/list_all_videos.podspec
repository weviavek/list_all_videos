#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint list_all_videos.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'list_all_videos'
  s.version          = '0.0.1'
  s.summary          = 'The list_all_videos package is an indispensable resource for Flutter developers who want to efficiently retrieve video file paths from a user's local storage.'
  s.description      = <<-DESC
The list_all_videos package is an indispensable resource for Flutter developers who want to efficiently retrieve video file paths from a user's local storage.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
