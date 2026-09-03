class CodebuddyCodeAT21431 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.143.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "5d82cd1d9ec127d44d7eefbbb42912b46a0acdd68bf9565a56e23a303f7a88b3"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "49ee632c5a6b1c123599c01646c3f2171b9e7ec4bf15e5f5de45b27d401ee529"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ced24391a0f43fba19bd7510829a9e6bea12bfc1ce9b57c4849ea690bb076aa3"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "50338dee27d3b295861c599fe54c3240eb29892ffc4b2e9bed20bff2555b8661"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ef1acda9c7cc3ca2793a424007408e70df416afff260b3e259c111c06ed732e3"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "5f93d162ae15dce40b7802c2641d0ab40785399e250f916f2ed0d5402f6bd1a8"
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
