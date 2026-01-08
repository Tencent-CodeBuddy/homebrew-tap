class CodebuddyCodeAT2310 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.31.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "380ed0ae45ed08e2bc2bf32c7cb3d855a95bf5b1750610f95a338c93139c4167"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "f8bd1cead74de24f65bc60d5eb9fc0a41b15060bab8062c214edf8bb1c190433"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "057120ada6a682e4b711ba6b5b2c7cc33e266bf4b4ab01e44467155214a69038"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "736e0b2fca30a5575424d01c4ebec71d5ca3d72d0338125b779b3cb46e6526ff"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b7649102570ac4ae8d569789bd9dcf946db5c9e81cb4fda41a75286b277155e8"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "7c19562838833ba38e6a3c438f2cc774fb13cbd670319f95ec1cdac0760cfa75"
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
