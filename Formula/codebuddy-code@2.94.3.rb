class CodebuddyCodeAT2943 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.94.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b9632eea53e46473a59c6fd5dd5ee484ad83bc9447fc33538a7646dcb0cde3f3"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4befb61de0af4772b9dffaa3d819e981ede8df9208dd4ac186725a07aadb5244"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "8328187d92e0584904ef3b64744444d756f07b571e74a51e8baf589144148c20"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "422755fa9a4f16420e32204acc494c00c7aa5a4a0da9b0b52237c4be25baf6ca"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "bf29ac05be3a7e0658ca36d695fcbf975f0b4de575174cd41e6dd6dd8e745da4"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "c8512496241b272633f227671b14035026b6f28e6f68f0d5eab42d3adf884d7b"
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
