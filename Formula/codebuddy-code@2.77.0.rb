class CodebuddyCodeAT2770 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.77.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "229acd61840c034f3b07fb977abc8f52dea8047797894993e1d2e4c83bb17499"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "5690d265ae4d3a078f9492a81958bb0aef8c784878f351c659e9f01a5aaaa49a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "1ac1aa317f4f6be947a2929135db04a476c1cffc02846cca46fffaf26b0f1159"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "021a6006b5f8e434871fe006b7114740e1281ebadbf348d0ba4e856ae1739411"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8f1bac5bb490eba7cc6909f11ef2dbf70226f02b780bd5a6fd0d9394b6d7c896"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "427834f89d3b0f73be5dd61a5a55a999ed4d1af9fba73e042bc277f7247b3331"
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
