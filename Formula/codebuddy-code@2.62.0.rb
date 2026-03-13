class CodebuddyCodeAT2620 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.62.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "7c7f1a26f79e9ea3317946ddaaa21805b31dfcc1775e5bb404292d4bc3fec1af"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "5b4702ce2f54e495938d48a397bd59dfc6cf7c00fb7b5da968ce3f9fc928fef9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "c767a4881f2ca51240cbee0b02079d8271845ac487e246dfe6e5ab6220220d15"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "decc5ecaa81cadd05e49497e6b8eaf4d4828555d711d17eae62bc04b8f7da273"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "36153562a73247a499ed0dc6f432382aa9c07421e712787020a49ebe0af3d19f"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "572109203d27f77073af32ea60d84e1c159b1f5af31f4071351ee5b450c9b7bb"
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
