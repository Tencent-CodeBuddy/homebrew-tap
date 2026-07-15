class CodebuddyCodeAT21220 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.122.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "0fc450b430de5710e0cf1a668413f70d58b997899743ac8420078a069813ce44"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "3ee4e390ba91adfb8d5432e9624d1d5a2030aa10a391a97947c0e8447c771b22"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "71a9ac438d1b421211d6c265c76060b658d9c5900966208945aedf84831f2c84"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "1db788e3a04bb8a1afd6f2f3197dacf08a1611a4a216dc91a174e45b909776f8"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "26554aa5cbaa46a212f2067d5109ce630f1a15f73ee0d2596367419107d2b783"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "31484ff1a5af25a2fa8f1ccf09ef2a1137cc2e3835b21538a87821a6d9f2c36e"
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
