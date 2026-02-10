class CodebuddyCodeAT2494 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.49.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c4783ae7e2a53615ba56871df12dd8f4340a1d7abc16c0a7fa1eaf583c4b1265"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "aaab89322dd1ac384e4081a58a6d4524c16b6ae04a6ecb0849741efc2d9a47bd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d366d037f81576563f80175a4903917437294f1695bf6d7d3e1e1bb33a733005"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "e115a15c7aad42de48105546414d425550ece93c24373bff2d39c4ac2c64876b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c777763c2d5d799aba41c479ff33e003e6abdf06bf18c29dd33578b986edecd6"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "042720f1c71702c6854fa01630650a54d03ee1036ca6e8945968b728cfbe4868"
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
