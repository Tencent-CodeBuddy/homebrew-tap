class CodebuddyCodeAT2503 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.50.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "d09f3e2f4eab56aba92db69dc26a89879d6716e0ff6c2465ec80d211e4980942"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "fd31b2469657d212d4fbce9cc7a1b7eb7d2984014017b2b42cb4af9b24bffb2e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "8ff7f0cf83ff84283a65e39fc67cef9591e160e75b2d3386d6858c5f1616d556"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "afed35a563a9b2d82f1b2cc3801095ffa50f0418f5a10d41a263eecf7ef80c16"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "a7470fc2186e9f4a2608f5bd8ed3946d1ba0d2e0df44e7f76b8b0268c111f66e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1e90fdb07dcb07b9aa1840c99ced8812f420a11f7b1e55a325c96d6b0f799e7f"
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
