class CodebuddyCodeAT21270 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.127.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "74603af5bcc60f3c21ef779ae7994ceb19393b3671a608b8429879aed550ca2e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "8ebdff5649c1567f7233f52cf8b945bc3876bfecaf859313fccf030e89ed1d25"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "910aa58fc83d0c5291587659410a68b8e8ccfc8f7be730986e1d3156ae750cb3"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "c6588275a2fb617d1beb59b550955383ad1626742f8a6143cb0c8efbde6a5a79"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b291cea7489b8010c6e81a35a1d67ca6946af7fbff4e4a7f9fee17a85da30073"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "a8abed0bbe994519d4bd02331d6dff4af5062689dcff0d536cc55a651e5369d5"
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
