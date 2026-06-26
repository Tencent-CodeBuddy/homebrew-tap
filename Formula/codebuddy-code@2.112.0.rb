class CodebuddyCodeAT21120 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.112.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9b30ba255f42ef508208804b715fc8ac152c79ffd9c5d65a879de1157ddad9ec"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b77a68dbbe34f4e36a6caff4a2dfaf249a5ec1ecc41179fffd79360c4a139347"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2f65175327c15f90ed924303cd67cc7fd55aa34aaede1f0e04f22dbcc2309047"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "add539f07094a17b724041b529ed8d98896b341a0b0412e2c7462aec5bb12ae2"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ff3cea50bea905c867ec4f36d226a8f413c7651b165528a47c2bdefc039c581d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "6b733fb0a875bce668706c7d17c3594a8be143fa8ed345d915c2125bfde9f301"
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
