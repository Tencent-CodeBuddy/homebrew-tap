class CodebuddyCodeAT21740 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.174.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "48eaf282a9fa6c6d3d041f9d09e7214b1ef1eaaca6ccd09b4b5b9c847d5465e2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "45db23bba97d8916720d62e12704d1c40a856bbdf35cd96a0e00768c9854c12b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "fb881a4c327ed6f8dec7d4fef2d73c1f94a28a028c47a75c900ef19073213d04"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "22670ac20e1055ecb9fbea22e50127ecb83a97758e1429af29afedbde310609f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "5807661f5bf72d1b6995b6f90ca98302560bcc50f14af17ccd3532f043b8a872"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "f28a03b1007b52a1432b1c31bc2a49df5cc586752715c1bdde813228699733a4"
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
