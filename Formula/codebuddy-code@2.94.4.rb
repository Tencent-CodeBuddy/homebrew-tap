class CodebuddyCodeAT2944 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.94.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "39bc51dd68c285796819779b5e11570f85a9959df6c76d0b58559a2b002b9baa"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "45843d42d1ec59264385ace5f71391c16b31d587b1db377f57c2b3c2c8fa96f2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "5633b389eb7ca1868bfac7db422a334bb0771d330b1c69f5d6bee5e2bf264444"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "537f5f80370ce130a1a75a4e2b1945c84088f94042870465197f5fa2a2a81e10"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "75abd036453b8a71ded123d4011dd20b4551aca7a4a341b1a796353d2bda367f"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "9e7e2513fbffeec4daab8b4619b04371892c4b5e656c0c457ef3aa060063252d"
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
