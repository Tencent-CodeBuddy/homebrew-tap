class CodebuddyCodeAT21371 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.137.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c2b592b8b2881e4934c579077a3a0d82453c9f4b20102147608ca0bb6f56f68d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "85a5c79fb6db9411f532a90136eb9bd29def8d03f59ab3e312da1c2ef90fe76d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "6eab2c7e59014e05e5af1795a01e6c8eab4d9127ea609065244973f4ae743380"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "fe75f4491157837460d33fc201d9062dc1dde67c241ffb96bfac96dda92cbda1"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "4b9488a831e40b8dc7f25f39f27babd5b0305bdea8aaa8ebfadb819bd0f9478e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "a09e887057cde96383ecab875faac7a3d357094c7147f3bc3a69dd7d68d2887b"
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
