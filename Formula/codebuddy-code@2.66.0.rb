class CodebuddyCodeAT2660 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.66.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "07919ca4116502fc8dd924885f2e99a21d0fc05e895a67c16983197b9d160f0e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "695ca4e3c1d0e69c4485786e663bc92872eb48f7f098d8652a3ef1b9c9956cc8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "14fdb83cd66655d1fd754d11ef940583a2e7a33bcd3af3bd313e44531a6fcd56"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "21a803d2b9b6865ba34720dec1a0efe87d13701571ce2a286b8de7762ef004fc"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8dc7b636e70b7046e7b791caf28bda1786f7267787bb36bd6873783dc31fcdf5"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "06efabcc2bc8a6604742789848800dbe81483ee07aa327c939eadc62c7c52e6a"
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
