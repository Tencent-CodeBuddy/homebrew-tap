class CodebuddyCodeAT2451 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.45.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "505be8e46b5ef43d69a1900ddab0e98512f6cced3534671125b78db53e5aee82"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4d96e46365ad5652f24dafcc0573c3bd7ae787f3fc4cfa6b1f3334481dc02487"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ba8978cdd1736a6c316476a671fb49b02bbfebffff75bfeb2e82032e5565ea5d"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "6c89723903dc479e6a1c02e1f5178996bc4050d931b57c93e7a81dbd57aa3e5b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "12f26ee74721d964dcd56f6a9495925d6683a124b65018a3d678731af2fe7131"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "60ffa180acfa5ee15df112cf7217a72da67df9f1b165a762991ba8c2b38513b7"
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
