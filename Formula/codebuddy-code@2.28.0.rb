class CodebuddyCodeAT2280 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.28.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "7a7a057b9dab82f50e0fdc4056d154ef988fe5db08e0a8c15f03d43ef972e88e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "f1bb1d5132bd94670dc3c69358212d846b9edc2ed7a46938b81368906be15259"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "1c4df3591154194788609517e59ebc8a1b99d8cb0dd8b52bc53f46881b7931b0"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "8107f2bc0ed69e934229bfecd566a8ab3d336d15600dc91fcf716586012a1c2e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8a33ee26e1838d1d02ec592c2c78ff1094cc0de3f6fcbe0d6d32b560325ca8bd"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "8b8bb501d5260917e792b8e71df776e7f6e4c2348430d5ddef3920605cd8d2ed"
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
