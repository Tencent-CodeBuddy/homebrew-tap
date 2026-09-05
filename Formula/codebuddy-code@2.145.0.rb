class CodebuddyCodeAT21450 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.145.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "01cdd5c96d54311f06d162de2680eadc4dd8b193efae87a2a8026d506fcf92e3"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "974638a86ad6ea240422ca3d56474255fd8a6042e5e0c616926677f9d692214f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "7c4cd85b2bb3259540b0d1bd9d0f3269b01850aab74351e9e11827a3ea90e89f"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "358b1c51e7e5a802189c3e8fe14a06acbff0f08163d6e700e930f660548d3153"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c8fffbc4ab799a58abc4c8eac8eac6dc5a2332fce4ae8a44cd70b94a18388d9b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "69832bd63d5808aa794ca8c4b3a010f5a9cf6fae6963e40ec70bd7f45009ae2c"
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
