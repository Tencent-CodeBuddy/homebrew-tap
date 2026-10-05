class CodebuddyCodeAT21614 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.161.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3e39a661e945c8fab4955672d9dc1dfb01c4ba16ec95faaa8cb2a21d2e1aa5ec"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "1731b1f65e30b17303e0925aedbddb0439b48f20cb5d30f944c0ca380a3ef4da"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "be2ae15497ddec54ff0de378fe5871739af0481a20d7424b5591bf9b2d73db05"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "35c59a8c2af287f11bc27f340c0f434a12108002166f9a563dbd279e32e50592"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "32c92a8106af039288f37272e3661110f58b2dbb5d724e7f89f1c1b31b4d720e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "308aaeac6185ea8437bda3d67108a5904249799fb521d0c153859c55fdcd1226"
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
