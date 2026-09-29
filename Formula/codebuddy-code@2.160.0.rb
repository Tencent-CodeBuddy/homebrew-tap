class CodebuddyCodeAT21600 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.160.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "864e32b7f7ac40e316d4bfd49efeffc6ace8900f59db6c914441a466c9e05765"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "0afe7cfbd94c04d44b3b0c71102808b2bb315f46daa905dc2753946ac6710c55"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "f9af17fd85879d20279d803580947647eae98d3dd62a275daaf1f9ac63af6bdf"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "bd3bf92d428b86767dce6a7bb81c42d19b8530b96b0ce18dff3c32c159f57e05"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b8af4402f1d8b4584f9c31ba126cf548ae1cdad74b7bef48d2e4131fc80ab380"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "cf3df55bba3fe330d51d1ddabe74def01e373237891c0877e65328a884d2b3cf"
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
