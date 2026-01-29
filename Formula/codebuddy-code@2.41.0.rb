class CodebuddyCodeAT2410 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.41.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "7ead3eb9694317aa0e4fba62d3b6123c27d18bb1c6ff48c894b3e526b05cfb04"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "74c7def6f082a89949d42f64a86a88fb0bbc1c28b5b3a2f3b10612411a069669"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ef09cee5c54bfee9c3d31a808dd2a6c7e1badf950f0c67eb5e638ad9270207ea"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "33ec813d40afb6055c80be281ce28c0fab6f2d6338800decbf0a1aaed23a21d2"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2e98e6f3ac9943425dfa3fd2c091747f0fa682679e03f89c1f6ec68f2a5a10d5"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "fbda07e1a8a65ecf6dd04584ccdd1127b5879dffbfa4c7ef9d3ab44e3b5cc6da"
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
