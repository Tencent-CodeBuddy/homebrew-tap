class CodebuddyCodeAT21063 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.106.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "d0fba822f396d72eee2ee205f68d2742da1288fa2d805f281e2c0f867cb39dbb"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "5a449f75dd2b7a797a6a1360197af6e6766085bd812fb69e22bdea358daf0ce9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "bae8b2875eefd0b5c725c2e508753b9998b5c438a1ec6537f3042c59feb8c37b"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "fbe6f285ded78e98db2934209b3efd10e550be6b9793dbd671d896ca1cfbc305"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "d3a5804916abd006d5a970c97908cc8eb34ecaea10580622dd8350343d979c48"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "62913ce696b40990975f0190fbe5ea3c1173cd455d4fa6be1b475602142121c6"
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
