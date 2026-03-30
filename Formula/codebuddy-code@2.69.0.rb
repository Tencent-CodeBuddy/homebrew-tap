class CodebuddyCodeAT2690 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.69.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ae6a31f0c035cff53d1bbbad8f42e63d8d527f9f3a779a034784a5e16ef63dd3"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "e7018f0656babb64eb168097fcfcc0d32a77abec43c1f253bcd9b4324e71f2b6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "39a015cdab7cb4cb5fcbe3f740801ad4df64e612714b3ec86d8501c0d993784c"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "12c7afa0a40d73acf1a84664ffa0e5044cb9dbc077617fadb1e67194db16b2c5"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "201c9af118e9e944ed6139fddcbcf0795313b037a7d1ed59b27b7708187a1063"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "36f1ed10111d912531fec56637ad0645c52cdeff17c8170e47129b6cd1a65cb1"
      end
    end
  end

  def install
    bin.install "codebuddy"
    bin.install_symlink "codebuddy" => "cbc"
  end

  test do
    assert_predicate bin/"codebuddy", :exist?
    assert_predicate bin/"codebuddy", :executable?
    assert_predicate bin/"cbc", :exist?
    output = shell_output("#{bin}/codebuddy --version")
    assert_match version.to_s, output
  end
end
