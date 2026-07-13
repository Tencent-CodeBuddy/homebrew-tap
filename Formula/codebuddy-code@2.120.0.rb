class CodebuddyCodeAT21200 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.120.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "5939e660b14d6c59c2c17db314ba76c7b14a5324d127a41340e5be8d8cfa14ed"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "565bccabcff3b2f53f6ef865462894e445f766af37a772113ca193664d30dc38"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "afdfa96404e8db0c8db9855ddf9b53e8d954ec68218de3d525c145c2ef9f2f35"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "b76a5f182eaadf9dd82c131029f219dcadf24d39e472a33f3b47873667c14927"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "cc97aac78091c01dc724dc6966c17542095dec8f5c4e58f286c3b73e30c01947"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "ccca51e0a6375041ec73e564ec9ad326703f199541b392c611d43f7225e0ab72"
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
