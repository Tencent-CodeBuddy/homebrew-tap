class CodebuddyCodeAT2363 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.36.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "66d6f2d96af527a13496a4886636792084901e45e36eb06f60cb4df6f92cebce"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "af401bf7717b0cd46023181e300a47568f6810203e64fdd8568f25b5982ba3e1"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "02371b1c040c3b8b3e19b53421d7dcbe9bae1ca1f2f17655201f82588068f176"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "bc518d155e31d34728a4012331e09bb828fd04d6d8a406a9da029dfe999f9abb"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "3a8a297a7ec322dc212bc34d17d0e7b915bcbc323bc7c3fe193c9ecd2031978f"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "a61cf8eb44ab8682f8528deb66c6b394737b0fc13753a3f4c9facc5bb1bc9424"
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
