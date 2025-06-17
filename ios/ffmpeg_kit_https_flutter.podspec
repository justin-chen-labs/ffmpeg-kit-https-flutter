Pod::Spec.new do |s|
  s.name             = 'ffmpeg_kit_https_flutter'
  s.version          = '6.0.3'
  s.summary          = 'FFmpeg Kit for Flutter'
  s.description      = 'A Flutter plugin for running FFmpeg and FFprobe commands.'
  s.homepage         = 'https://github.com/arthenica/ffmpeg-kit'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ARTHENICA' => 'open-source@arthenica.com' }

  s.platform            = :ios
  s.requires_arc        = true
  s.static_framework    = true

  s.source              = { :path => '.' }
  s.source_files        = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency          'Flutter'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  # 设置最低部署版本
  s.ios.deployment_target = '12.0'

  # 使用本地编译的Frameworks - 带GPL和编解码器支持
  s.vendored_frameworks = [
  'Frameworks/bundle-apple-framework-ios/ffmpegkit.framework',
  'Frameworks/bundle-apple-framework-ios/libavcodec.framework',
  'Frameworks/bundle-apple-framework-ios/libavdevice.framework',
  'Frameworks/bundle-apple-framework-ios/libavfilter.framework',
  'Frameworks/bundle-apple-framework-ios/libavformat.framework',
  'Frameworks/bundle-apple-framework-ios/libavutil.framework',
  'Frameworks/bundle-apple-framework-ios/libswresample.framework',
  'Frameworks/bundle-apple-framework-ios/libswscale.framework'
  ]

  # iOS系统框架依赖
  s.frameworks = [
    'AVFoundation',
    'AudioToolbox',
    'CoreMedia',
    'CoreVideo',
    'VideoToolbox',
    'CoreImage',
    'CoreGraphics',
    'OpenGLES',
    'QuartzCore',
    'CoreAudio',
    'MediaPlayer'
  ]
  
  # iOS系统库依赖（根据编译选项调整）
  s.libraries = [
    'z',
    'bz2',
    'iconv',
    'c++',
    'xml2'
  ]

  # 弱链接框架
  s.weak_frameworks = [
    'Metal',
    'MetalKit'
  ]

  # 编译器标志 - 只支持arm64真机架构
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'VALID_ARCHS' => 'arm64',
    'SUPPORTED_PLATFORMS' => 'iphoneos',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 x86_64 i386',
    'OTHER_LDFLAGS' => '-lc++',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'ENABLE_BITCODE' => 'NO'
  }

end
