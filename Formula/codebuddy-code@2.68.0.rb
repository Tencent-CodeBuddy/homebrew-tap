class CodebuddyCodeAT2680 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.68.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ac8e63977b5e00ff13a0f88466c81d34a4418ec169937ef1c6b082b7a901c28b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "2a4033b2bec97282ef22e16b07a053c931127b350df59ad431bd867c4964e10f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "b00acb46840ca5b1fc38e2ec9694a416ae303706399d096901a114c0157900c2"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "d1038c42f5f598dbc2f40160eb0ef6b775dff1dbc7b0aedb0c01fab74c41ca53"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "09e59fdd2eda8dc91a9040f65812f2dcaac0fdd514a25fdf2adf8799b075d747"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "514282c990d36266490573e3159f9fb334a25bd9e8960ba041414c7fec35501c"
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
