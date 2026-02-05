class CodebuddyCodeAT2480 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.48.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "db4f2b630dfe1bb4d44ae45077fd568384dfe811b18dd5f1554598376fe7f5af"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "913b627783b1130e589f65312bd251ecefa01ddb8e7a5c0ae9b63ca0a0213b0c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "8108fcf4dad053a601c97112b17d6478b25c2a38487997720ce3a99139b33fa0"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "33b844bb518d8c8d3cb20f1d6ffd07d5e6491975c51598e44e122486bff42aee"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ae391b26edf292b486d2fd01a39834c4e8fc3149de8eaa6906a5445077317bf4"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e56d104ec2c49847c53a908f2e1c1e17e1ed910d56aed968f6fb04b7ddc1498a"
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
