class CodebuddyCodeAT21470 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.147.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "125833ba029d6637f5ba00f7a2735a8fc39d90502002e110974689c117086d09"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "f7d41b437d9904d1004f2e6f4648a7f27014e20ab32b71b093e9eb67d3ca7bd2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "7b5a6167a5eaebe82fe8f03960bf832c18cca8c68f5dfc88218aa41d81dd3e66"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "03e716b66f5663402c64ccecb7bf14791014bc2c4e7c9f7e9af5b4d68c91b492"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "f47b68e921e1cc73a017e839a5c937adfaa4cc3413046c9fd201c7f8940f74e3"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "5ce2e56244932eef43acada4a471ebe0f11586f53c5271725c365137f3ba63fb"
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
