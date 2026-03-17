class CodebuddyCodeAT2632 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.63.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f1e6b400c3f3703c45fbf62b0765a26647fe3b5e0aa6dd80ef0c09c422bb5a23"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "0209c772e7cc6e9a53661d70cdf5783fe9aa718917bcb69f92f8fb8d92070802"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2bf83c982d3bd5796d1a1b7171f87c99d799b2ee8e3f9ca32479fe1de3c8938b"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "77cc456ee80568b673372d9cb4aa87eee5a86828d1feaa2e5b8bf007cebd0134"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "0f8c72ac975083241493201d7773b3df1120ae993c0c1413bb2ffe386c57e898"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "cbb3ec01d6d083fcec6bf345326b5acd302e3d549dcd6e24db12ad9bc2024b3d"
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
