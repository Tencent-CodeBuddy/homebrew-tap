class CodebuddyCodeAT21820 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.182.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "07948c0189ce9a7d510f27370ec0ca3e0d5619ce42cfe46160d742927429fa71"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "80c7cdfdeae09d5012f4ee7c5513f0d84333532df4ff8747f976c6e1a95f6d64"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "cb049dfe4cd1098beac204d0b752c9c5f3bb34955fb8b7143d708c06ce164614"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "cc8097ba07ae44819c5f5d13d8f71e6072e3190a1e0560fd73e9ebed560eafec"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "89b9ebfa2d36983203e1320a9bf106596169e27b2ee19bb2fe3309929fdd408b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "6bbd2a42fdab1eee7d6920005e9e1be6c868aba6529d6f819d35c987578a22cb"
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
