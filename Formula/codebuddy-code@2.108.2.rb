class CodebuddyCodeAT21082 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.108.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "014c419141867cac9d538a8c56b36a940419be1b15446c5855265a441c4fcc9d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "bb61dffaa35d48f195cf3b31a5ba4a9d2bbea9b862370fe43b248ac02fd2cfd0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "bb8d6287645a1b197c40abe8d3cfeda1a7939da08d5172266357682a6a1dadf4"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "1db4ae719340fec791e27da5a5c052ea26a345c6ca07a6d8a437587ce6e494d7"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c1a53c8742afc43cb2ab4281053fbf51882b037d34beb183fdfc979c469343e3"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "f078b72113cad95a7ff8854983e5c153019c92a9d83173a09d2926d9d8213176"
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
