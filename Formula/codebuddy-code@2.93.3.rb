class CodebuddyCodeAT2933 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.93.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "2a9ac5b7b4a32872fa5e537f63eeb962dab24962631b6bc623cc2fb17c58dbf7"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "352b2e895f2c856702487fb7eceeab7f010f63a2a9df62bf78c3936be4eea014"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "3d53016bf1b40615ee0f542bf050f7432f76b8ca225abb66d3a0a3eb60503809"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "9674559d445e5d9399db6325dfa65e3b3c5ca9368ebbdb1a3470b7a5f849dbc8"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2139edfa221fb34ff4bb00fe8595e6566ac009132f08b2b62da62530b743210e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "0d1a1040e6f229e1d43e50979cfacc96bab4c7dec2c7943ad3c502b5b1dbc80f"
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
