Pod::Spec.new do |s|
  s.name             = 'ffmpeg_kit_https_flutter'
  s.version          = '0.0.1'
  s.summary          = 'FFmpeg Kit for Flutter'
  s.description      = 'A Flutter plugin for running FFmpeg and FFprobe commands on iOS using prebuilt frameworks.'
  s.homepage         = 'https://github.com/chenjun1127/ffmepg_kit_https_frameworks'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'chenjun1127' => 'your-email@example.com' }

  s.platform            = :ios
  s.requires_arc        = true
  s.static_framework    = true

  # 使用简单的 git 源，避免复杂的下载逻辑
  s.source              = {
    :git => 'https://github.com/chenjun1127/ffmepg_kit_https_frameworks.git',
    :tag => s.version.to_s
  }

  s.source_files        = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency          'Flutter'

  # 设置最低部署版本
  s.ios.deployment_target = '12.0'

  # 修复编码问题的 prepare_command
  s.prepare_command = <<-CMD
    #!/bin/bash
    set -e
    
    # 设置环境变量解决编码问题
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    
    # 下载frameworks
    if ! curl -L -o ios-frameworks.zip --connect-timeout 10 https://github.com/chenjun1127/ffmpeg_kit_https_flutter/releases/download/v#{s.version}/ios-frameworks.zip; then
      echo "Failed to download frameworks"
      exit 1
    fi

    # 创建Frameworks目录
    mkdir -p Frameworks

    # 解压frameworks到临时目录（添加-q参数去掉警告）
    unzip -q -o ios-frameworks.zip -d temp_frameworks

    # 移动frameworks到正确位置（处理相对路径问题）
    if [ -d "temp_frameworks/ios/Frameworks" ]; then
      cp -R temp_frameworks/ios/Frameworks/* Frameworks/
    elif [ -d "temp_frameworks/Frameworks" ]; then
      cp -R temp_frameworks/Frameworks/* Frameworks/
    else
      # 查找所有.framework文件并移动
      find temp_frameworks -name "*.framework" -exec cp -R {} Frameworks/ \\;
    fi

    # 清理临时文件
    rm ios-frameworks.zip
    rm -rf temp_frameworks
    
    echo "Frameworks extracted successfully"
  CMD

  # 使用通配符匹配所有framework文件
  s.vendored_frameworks = 'Frameworks/**/*.framework'

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

  # 编译器标志 - 只排除模拟器的arm64
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'OTHER_LDFLAGS' => '-lc++',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++11',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'ENABLE_BITCODE' => 'NO'
  }

  # Swift 版本
  s.swift_version = '5.0'
end