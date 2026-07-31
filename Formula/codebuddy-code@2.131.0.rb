class CodebuddyCodeAT21310 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.131.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "a5ae2a61c3f91f0f4c1428a6f5b195dae781d55a87f11afafd1b4b327c0ddb52"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "9fdc2e6bfd6ca64828225a6dda65c78fdcb8ebd295e9c4f5fd04cb8e3a1f9dae"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "8c16ac5f5aeabd756f7bfc77f6354afc1f566b4a40438a73b78706a2346c3214"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "de590b8b4f0d0e96d7accfc42da338061a92607c7af4de32f7c11f2dc2a38bc9"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "997811be06bc7c789154ecdcdb2f2d1a96d5ab3139a4fb6276b4c37d20d49efa"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "9c1717b53601e0f1c4315d60877282febf6594ba3be7a79654c0d23c1849a0d1"
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
