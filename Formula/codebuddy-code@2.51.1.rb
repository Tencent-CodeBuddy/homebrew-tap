class CodebuddyCodeAT2511 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.51.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3332de6aa2e812d282d618dee117a8a0849af06e893eab3a95cc93ba812b17c2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "1aaf294f8bb6eea505368c6237b651ccaeb6f5f6d3838257f01ae9e86da91f12"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "b0903a4a051dfa885bb2f71f9170db8fd875f8cf0efae6bd24d712397ff0c622"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "e1f609052f6497bf87f293c7e7090c51cd178f97caec0ae82786e47e29b79bdc"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "7b16b6128466183ecdbbede8b6ed14007a1cd2cf4865aae4429b66414d5dbdf1"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "28f45a85e0f0a90f1bd42f21ba56d0212be11981cb563def63ed42a7d5bd2a29"
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
