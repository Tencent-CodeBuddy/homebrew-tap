class CodebuddyCodeAT2840 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.84.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3e0652dedb545729dc0b0c02e1a753932b4745abae8c8fc8f15e993e94d7f90b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "98869476804e8076ac0a03f6e4acfad27910a99179d32574b35da313c79e1f73"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "caa4c53d3774eb3493e4c5b380502ab2a2a4e9d762a34c12f291924568bc1fcb"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "2c7a45f0f64c3f9e5e00e6a48311252fbc912b50d5c8b9f57194ce9311c8db05"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "04c3be9294d0cff00f56eb4b47328b8ff0ff53590c1ced593e88bc725e605e54"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "d32041a60f8307b758aa4d8a69aac930a9fdfacaa536405c7604f0ad9871dffe"
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
