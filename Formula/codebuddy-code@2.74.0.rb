class CodebuddyCodeAT2740 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.74.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f82c259222d9768f793333c4282700bd753489f1c4e7ce4752b1e9c0be78a6d8"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4cbd19ccdc981ad8fff859cfb17336e9882d6691eeafa301a95a43ae0340e9c9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ff0b73adcd3380b883ec40976fc14716849aa8590d450f1ebd56525a08d9e4cd"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "edc2357b61d269293969ebc6cf1ee016d5216a424414bb72f68b48d155f789c6"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "77ec70749d5644f180df0606945d05423fed787416565bc5e371af4fca7d1c2c"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "84adc5ad9875da7aabc39eb3283b1384049e78161f7290ab5d24b9cbe330ba64"
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
