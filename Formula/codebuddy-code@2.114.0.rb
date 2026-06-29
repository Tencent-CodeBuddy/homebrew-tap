class CodebuddyCodeAT21140 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.114.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9910a7aed9924962045f08fa0709bc9ce954b7023eb2d84aefc5f490b1816f37"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "53830f06be0c843a36c3c6b2bd8b470808f25380c45dc1a5f297cf18deb7400f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "097077378ecec64a1257bb84ffd725403658a73cdc417df8c31c73e963ff90d7"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "49e82706d05fc329cc1c896d266be1919d5ebefd04d24683eb56f362fddd33c8"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8274970faf27f9b99852012c130891ac87576c31449e9b5207c6ea0205320739"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "d01f5a22f58d3a8588af5ebd8c0437fe0857cf249d75f24abed9dfb8588b0ef4"
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
