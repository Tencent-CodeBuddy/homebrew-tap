class CodebuddyCodeAT2400 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.40.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b3060ac8b533c585d95575a728653cd0e79105e6e341c90385336ae7edccd953"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "5c72c027cab65d328ff6568e54e37f79ac7f32082ff623270bd9ef7a62fc521a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d6bedb250b30f919b50119b99f609e9818458be0e02113a6a357728c5bd5ccbb"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "517c49f54cdaf820299c74ba572ded58fd6c98ff8080c10d2cdcb34d3346b9bd"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "6f5ec45b04aee776270c620efbd58540e247f9d83fce19dfdc96e5471d271af1"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "d56aaa993e6f3489f1bde2d1f69607cdd3ad1d57018d08c44150ccf3e4ce3479"
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
