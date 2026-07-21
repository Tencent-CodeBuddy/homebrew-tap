class CodebuddyCodeAT21250 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.125.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "d1de030caffa0ec02109d0bea3a896c2a11cbff0f615c7d0ce108ecc591a91d2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "db647081829d6638b618d37aa65ce674109fef7e78e856a217325c6f3f0566b8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "1e98725f8ab1a34abd06f39e5d278aebf1c3be7345c6156cd1836c04d973c342"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "e50485ff162a52766640f5dadb6fe231a50db15e269136f6b23ae72c9a7a4a7d"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "00b5d285fed974bd0197b06422b3bd8e79db125af54998708aa7628a6a42781e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "f9a0329bf2c8a0d9835dde618ec6ffd4e8c97ae66a70e7634c2061137deb60b6"
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
