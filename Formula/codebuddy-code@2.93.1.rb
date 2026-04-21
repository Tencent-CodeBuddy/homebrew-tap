class CodebuddyCodeAT2931 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.93.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "4fa69b57d0653d6c7c322913a0e77fbac8c073dfa5aed0d71530615f47028154"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "6cdccea68281e7ed1bd110269d25fa442fbfad8675538c1f5568b8b95b5909b0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2839e81c314782d02ab227bc61881976951cdda3c3889ec5024e225827b1c6a8"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "49d699b5efef7cb5db5d0c7301953b16238655389c7c12b2c1a2de3b5f9798f4"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "166c559e3ee07611b4a20830c8df0b20ec3e8006d7ac58a56c3fe76c324701ff"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "fff02ba60483e8c048af8007a6cc4e5a535be507dde0c51e3da89a5836829c86"
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
