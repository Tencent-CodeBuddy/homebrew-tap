class CodebuddyCode < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.173.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c2cc80a61ba57652f27961b0dcd38fc129934913d742ee5ad80e93bbe068faa4"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "877f61c07e46b94fea9ebc09fc0f9dafa81a67a5af73a96627fcd3cf46f1964a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "b367e1a448a718718d54e2cddfe0603ac1e6d8f6e25160b9f18caf27ccc48519"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "8f11e366af2949a9c4ba89ea1a6ab834a5c12c9f0356fed5f66359ffcb19c051"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "cf4c87110754504c7b13259edbc635cbb7b23cb1f407521da5a0587e90fc59db"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "7a3fa3e2f2fde28abf5f61c97c96bb5c22a605c6362b8f34a47c86b1c57c5f03"
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
