class CodebuddyCodeAT2750 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.75.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "5008290f1182d590e1ddb16535aa3e864f903d2f012af944c48c1a687794120a"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "98685d92e6b787dca8df7d3b85d68024b8476a44c469cf6ec66b9c500a862f16"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "bd00889660f647d2a9966621563bfcce5c0da826999794d44c36a9e5cd69fcfe"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "0838b08d78b7793d969008182ebf2a2f6bd9a75eb5b95f61ce53353ec5e7a2c9"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8a4859c9ba081011976b58e1e353f7aa039dfb78dd02a4d4bbe407a51c625f1d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "61b94c76b760ecb09d2d3938aa6a557fed1216d5fd179f7036619c7cada2e62a"
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
