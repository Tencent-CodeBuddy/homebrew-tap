class CodebuddyCodeAT2418 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.41.8"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "216fa50870d06b6475ca6a20f85b122c250876eea1a5af388d9eb12a47e6f5ff"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "31d39eb7b8b28f5b3523131e61e490fb80c45a9464b4c191d4df9c1a8f9db5d9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "023f51cbbb2755173d2d41a2b979ad5bfc8102b14e25ccf4ed685dd0d2b36036"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "0f234692d79c4f52b549445c05dad59012b6ef3af596eecc336bc2d156858c56"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "4b181ae7882873109a11da5879da33f382a0b2512fc5c85e5e48f3bbdee3740c"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "f6bdb1f10efb51a14aa633cf03d4c878c81eadc415b6c6c306dcac17b65d28a8"
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
