Pod::Spec.new do |s|
  s.name             = 'ffmpeg_kit_https_flutter'
  s.version          = '6.0.3'
  s.summary          = 'FFmpeg Kit for Flutter'
  s.description      = 'A Flutter plugin for running FFmpeg and FFprobe commands.'
  s.homepage         = 'https://github.com/arthenica/ffmpeg-kit'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ARTHENICA' => 'open-source@arthenica.com' }

  s.platform            = :osx
  s.requires_arc        = true
  s.static_framework    = true

  s.source              = { :path => '.' }
  s.source_files        = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency          'FlutterMacOS'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  # 设置最低部署版本
  s.osx.deployment_target = '10.15'

  # 使用本地编译的Frameworks
  s.vendored_frameworks = [
    'Frameworks/bundle-apple-framework-macos/ffmpegkit.framework',
    'Frameworks/bundle-apple-framework-macos/libavcodec.framework',
    'Frameworks/bundle-apple-framework-macos/libavdevice.framework',
    'Frameworks/bundle-apple-framework-macos/libavfilter.framework',
    'Frameworks/bundle-apple-framework-macos/libavformat.framework',
    'Frameworks/bundle-apple-framework-macos/libavutil.framework',
    'Frameworks/bundle-apple-framework-macos/libswresample.framework',
    'Frameworks/bundle-apple-framework-macos/libswscale.framework'
  ]

  # 如果需要链接系统库，添加以下配置
  s.frameworks = [
    'AVFoundation',
    'AudioToolbox',
    'CoreMedia',
    'CoreVideo',
    'VideoToolbox'
  ]
  
  # 如果需要链接系统动态库
  s.libraries = [
    'z',
    'bz2',
    'iconv'
  ]

end
