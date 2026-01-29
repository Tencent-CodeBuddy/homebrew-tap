class CodebuddyCodeAT2414 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.41.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "8ab2a0597aa0d59a7a5dfe8e568d20a1799eb42c28514b80c460acbd18fdd67d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "80b26681c13fd7f0eb54a765ad1a01921ac962c4cadb704b8c5e3ce78d18c98f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "fc7a430a477a83e02b7f8a846197c1412d8185ef9e11f7c77552cff75d270114"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "4c123aaf743d5955db430ff935f22affc8b7a08559721673ad43efe9cdbd45a2"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "969723c16af3f782b491a477f2bc1080fa15a82e99be1d6a26d1074b1e6f10a9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "79b4b5c9268feff13ed84f44dc7a452e24fc9c6361b09e4ba612956958406e60"
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
