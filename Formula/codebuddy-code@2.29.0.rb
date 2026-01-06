class CodebuddyCodeAT2290 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.29.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c693db0d08a9741032f78618595dd5b4bcc30c9b1355d72f590de6819eafa6ce"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "713115f500c013cc5f17fb4745faa1d28ead8d874285292d7af40934a50b0047"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "c83462a3f01c9a1ef49166a08517f3d6ff3f36c4d0ffdceb114d3b5c4aba5f24"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "5bfc0450f0886ebf3ca00727b234d10bbb4afaad0c3bb78e9d482c761e91a138"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "6b1836d37f5e64dd1e08633ddd4b45afeffd5957f9d05b0b7eb9f3da3cffb3d6"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "8bad9af62df98d84d14698b4133e79eea92b96748710f56910372f903a807ad5"
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
