class CodebuddyCodeAT21212 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.121.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "e86c4fd623fc0a1a5b2e29c236b1a68686792c28c7711e8d5c64b41eeea914e2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "52a93b1df71695db784c69e67ab3bf3c472c250eb272382117159045a10ad0ee"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "88f6d18cb9705004c5e8ef93c56585b6a2b9e0d3db63e278fa138bdac309b903"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "b4fcddea9c2c1d8dbf6ed9cf2982b6d64719a3e9ae1907b5370a4d8b448d809c"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "d194ad1e42ea9dbd245a991f9d85e89f67c50d338006f0660e893ca9a31676cc"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "dd5be8badb9c2342f3525a7d9e4e84045c3c19a04b0b45eee93ed232343fb9dd"
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
