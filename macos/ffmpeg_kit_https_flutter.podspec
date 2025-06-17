Pod::Spec.new do |s|
  s.name             = 'ffmpeg_kit_https_flutter'
  s.version          = '0.0.1'
  s.summary          = 'FFmpeg Kit for Flutter'
  s.description      = 'A Flutter plugin for running FFmpeg and FFprobe commands.'
  s.homepage         = 'https://github.com/chenjun1127/ffmepg_kit_https_frameworks'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'chenjun1127' => 'your-email@example.com' }

  s.platform            = :osx
  s.requires_arc        = true
  s.static_framework    = true

  s.source              = {
    :git => 'https://github.com/chenjun1127/ffmepg_kit_https_frameworks.git',
    :tag => s.version.to_s
  }

  s.source_files        = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency          'FlutterMacOS'

  s.osx.deployment_target = '10.15'

  s.prepare_command = <<-CMD
    # 下载 frameworks 压缩包（macOS）
    if curl -L -o macos-frameworks.zip --connect-timeout 10 https://github.com/chenjun1127/ffmpeg_kit_https_flutter/releases/download/v#{s.version}/macos-frameworks.zip; then
      echo "Downloaded macOS frameworks"
    elif curl -L -o macos-frameworks.zip --connect-timeout 10 https://ghproxy.com/https://github.com/chenjun1127/ffmpeg_kit_https_flutter/releases/download/v#{s.version}/macos-frameworks.zip; then
      echo "Downloaded from GitHub proxy"
    else
      echo "Failed to download macOS frameworks"
      exit 1
    fi

    # 创建 Frameworks 目录
    mkdir -p Frameworks

    # 解压到临时目录
    unzip -q -o macos-frameworks.zip -d temp_frameworks

    # 移动 framework 文件到 Frameworks/
    if [ -d "temp_frameworks/macos/Frameworks" ]; then
      cp -R temp_frameworks/macos/Frameworks/* Frameworks/
    elif [ -d "temp_frameworks/Frameworks" ]; then
      cp -R temp_frameworks/Frameworks/* Frameworks/
    else
      find temp_frameworks -name "*.framework" -exec cp -R {} Frameworks/ \\;
    fi

    # 清理临时文件
    rm macos-frameworks.zip
    rm -rf temp_frameworks

    echo "macOS frameworks extracted successfully"
  CMD

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

  s.frameworks = [
    'AVFoundation',
    'AudioToolbox',
    'CoreMedia',
    'CoreVideo',
    'VideoToolbox'
  ]

  s.libraries = [
    'z',
    'bz2',
    'iconv'
  ]

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES'
  }
end
