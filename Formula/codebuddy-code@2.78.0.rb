class CodebuddyCodeAT2780 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.78.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f893bc6a5c81077939de8f621f5b11ebacb6046f52b4b8b693dc1cadb20aad5b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d185d4836d94b6424bd666b5fc362fe6a3db768f5aaeffd630b9b9647091edf2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "60ffdb0225b1fc36047835f93d2866862adb43a64dca4d1384799bbe109535d3"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "cd45a0c65c73a62c1bfdb81e3cfad0b7db5b92d50b9901e070a66cab43202495"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "05e4fad272e2a2ebe16e5e4daf01807c2bee2169428a5d289e88eade49e65fe4"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e7f18c44cfdd5e4f0e06af4964436952dcda1cbb5f50a55157de89580b27b25c"
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
