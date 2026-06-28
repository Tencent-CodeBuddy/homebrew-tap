class CodebuddyCodeAT21130 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.113.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "71659178f0682d957b2f3d5b78580db1bd44c2a48fbf9553a2e870e313f97b77"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "96f4573e9fac03e861e52bb7041ee26e94a9a15bfc9e383f9f516a04a2dfa2b6"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "20d19ec00bbf0f923b7dfdd5ec7b2497e1af84257c873a4441c923ffd337e5be"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "08ae4c662fedbf8f0b2567002f73e431ee5f4e4b2ae59c26443db43c5b3e438e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2de3a8d37d7c19a793fc66a2b12037d6376c66200e7dd9d04fa783a80046ba80"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "6512548311151d0bb643c784b0c5a782c26e0702eb7b7c08e94338bc7ebcdd01"
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
