class CodebuddyCodeAT2431 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.43.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f70498011bf6aa04739677a5043eca939ac650d8f90daf6f219e059e3cdad50e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "80d4a1d5ecf614958d19ea9e2ed7c5d4e1d185a00aff5c954f36df403ee82723"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ad64e405f001c7bef0a22a7f91f61f56f6f880d02a0484cd88438dc056d6e939"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "88cefd050c545f1bf6ac1a1281e5b6734e9daec1edd2d7e9db333ea53afc5ade"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "4d271aa1b4c7b69ae70f2f3fb51290e887826cb7e96ab47003347cd096c7e2b9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "a6a48cca8833233836ccc312e0713e2736edfb285bca4814cf32deae4c050638"
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
