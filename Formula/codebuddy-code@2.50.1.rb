class CodebuddyCodeAT2501 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.50.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "2c30e1b6f98d8848d559eef597b8e7d356aaae203ff510e5f13aea433ded9609"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b5c01c1c521d9c270eecc3a918cc5e9bdd4055c51a94224d2b71909dede405f8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "b507dadf25a0aaf82876903e5d2bdeae6025075aeed9a48b0c6f28102bd06862"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "c1fa70370d5d2483c4b100f7254edfec46a1bff6aa13efc1905ef33c099357e1"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "5d0ec9e1c21fdd9318847413c28bb6a05c2263ce37b2a41dd9a87ce1599df042"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "9190d57a439b2fad15675533c6b956f44c9452cf669f0402588de231031e3983"
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
