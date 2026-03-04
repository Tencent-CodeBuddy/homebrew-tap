class CodebuddyCodeAT2530 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.53.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "e4e57c9132b1531dfcb183017a059ebee7c7424fd7dc7043cd51674f759a4a39"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "0a63cfa36f23e247bd5a4bdb32d2580b758fb98e519110ed2ccf96ea15dc074d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "29495e30c665501c4d2198ab511f929f67d02cc23a165d0ba0b4f96cb895b481"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "802c60a21fd4e6d98df5d8fa68f47b039f9ded3a7b6ac8481ee83c459d6a4fd3"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ce2408120af3a10f99bcf4b50df42cf07bf6076ac6f18376329dc7d07658bc96"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "6478d5fb3771d867b3a166477026be8cbd04c9f03ce8c029b11c2aa2bd6fd026"
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
