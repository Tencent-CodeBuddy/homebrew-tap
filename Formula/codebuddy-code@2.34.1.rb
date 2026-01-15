class CodebuddyCodeAT2341 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.34.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c4d098b27608794797c8894f92c0a74896c38e2752230a8bd5f505be5632972d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "99343ada6c8ae4e9198bd3349f02a58f647ba427abe5269fa5ca45ad4e7b950f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "5197c13bbb8f4a9c4fbec07b552865ab8a282d2e143d1e676a4667405db9d97e"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "907a57e4445e921e15d65ea9cebe2a60b5fb66d8a5fd54d4e6fbf929a6d888d9"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c0fccabf72e29a07461c067d1e3f7fac497140962764524bc4a8c6bd5150489b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "cce9ea8223e063bd7e85271b61b3d279fb0e241e3f24f265028a2c37a753d363"
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
