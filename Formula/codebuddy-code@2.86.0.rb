class CodebuddyCodeAT2860 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.86.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "5bd210238cf046d63656ecc81a0af9e9dbe469388b6d237c6beaa0d1c280ca51"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d05d54823b53ec5f66466108f5b37df3d52b49b8ec0920c92f9f796a8a0d62b1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "9657238b2d2af6bf2f357f79c8da5facf403ab6e6e7ea9b010541321d61e2c26"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "61fed7323284f9ef691b9f65f19f4b7ca4bd6cf19883faaf06f37afe6acac34f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "4a50c4e67313b3387f497d53c93ab75c3c5e21068336e23d237410383eef4426"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "4f48349ec6ebc6bdcef8214d10a76a7c1e11a6e940395c46fa8072b735e1b2c0"
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
