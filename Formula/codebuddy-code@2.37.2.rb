class CodebuddyCodeAT2372 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "06cecaf8756ecc9110a76b1e7d7b7cfb033141ac1438ff67b9c21600ec0d01ad"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "784daacb432591d1a276e6b3745f441650aa468e2e8f287c62a29066768bd7d5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "cb45866c18a38981a5e06b66f437d1a155058e777a03d83930b1d205381cd513"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "7ad5adb9d930a51ed770d4595798c85cb921c8f02b4113d4912dadca900ee112"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "72ff8d0aa3be583ce894c21dec66481ed4eeb1d0a06ffbb26a989761013b2dd5"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "4348287fbb335fd1a0216ae0297541839e275b87bb703cc4e60e974cc1a2c6e9"
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
