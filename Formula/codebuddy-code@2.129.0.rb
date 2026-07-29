class CodebuddyCodeAT21290 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.129.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "47df46cc8116dde8cf65e0cafb4f50a47b86c7d33ca5d637801d55ee7784c05d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "c6bcf627ab395f8a496760ab0516056f8146ab85da0cc1178d439edaef1d8479"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "3808ecc71abb26128807dd7ae04e6e2609e7e493326b8960575e0aa665465a11"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "092313628d82969f866a7d83645248bad2debe39b0ed23bb6f0dc2c289b8468a"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "4a3354f187b29951462f00a4f2a0d5ae55ed50bcb4ff48f0cbae1da4e782c73a"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "22f307fa8dae59875844c909e85e7ff931d763ddcf5547523b43b49e63b3295d"
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
