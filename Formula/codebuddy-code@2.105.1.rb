class CodebuddyCodeAT21051 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.105.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3376f1ac6da82cf5dffb8112b418944bb3adae64681adb34c9143e1cef9280d5"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "c8ca4f99f73fb3b36b386976213b8297e2dd945c158cf43fd20944e0dc94270e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ae8fad667845dac880b580d976744a87a2fca17745da8d3945e9a23c3c1d66dc"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "cc317518e7b9e06b314a8775014119c09fca98d70cfac50b7b4886c730ba946e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "046b029ccba22ee6dd7958a855d8cd9b2d38a9a478d3610e71e28d02e8f5fef5"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "025e8f5e1c7be4ab7ab70b3ee0dc7d8bda1b6ea64c1d9fcc5256027c9fd9b62d"
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
