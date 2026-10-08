class CodebuddyCodeAT21630 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.163.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "bde21846f25169f4514ab9494b1af622bb94d24ab4a57cdf42d1879d7864eb26"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "552ab9283f88df283db136b7861cb0ed32d8b1559f1649dfc8bbd5b4955d210a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "540be8e936308857c0bb870286d25d7b07720f76662e61ab7df7cba55d0597a7"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "6edb3d79556da254ce23ed9629d7c80a816cf37b5180052df2df46a2de4b921e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "500d13a7f82dd6ef8f7c70a99c33dfa39c94fb1a54e6b4b0c641825be54648a8"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "f5865aff155e73bcaaae70e69d2506d6f140f5c552d8f4caccf4bf6ea62acea6"
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
