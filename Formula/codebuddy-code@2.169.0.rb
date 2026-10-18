class CodebuddyCodeAT21690 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.169.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "4ab67e20c3bab80f6c2a68c7d08518969b98c94e5b2fcf403b64787092b6db17"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "01d02dea0885e40f26a5db224452e45e36c11919ffc47e80bb69f0faccf3c7bb"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ebce1a0dcd985943e5581e444476342794eba13049528238a6f35e147d05c03d"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "22375abe39b995bc872c8aab5e532c6f0683140292686d4b5286a8328b95a9f0"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "62171b3a25315bf75d3dd05120c9e77f96637e0017fbdff539d3e7c727062af3"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "42f0b097f74b0b3fa1bab310f37e7ef82b2bb7575d5d1d80a9fe22abfc25011f"
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
