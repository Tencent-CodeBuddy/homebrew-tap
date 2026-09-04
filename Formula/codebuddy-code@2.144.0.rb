class CodebuddyCodeAT21440 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.144.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "31d0a2487d1e65fd1e3a9e97c4d2bf7c145977e9c1f1d19b919d83e5691fd42f"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "170130fd519a3907d198c5e14a2f2f5b1a9dfcdbc4624511c38ee54d0faffd3a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "45ad18ec8ca989a70cdee74607272bfa003c2200db2149c47a2fba5d57741d9c"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "8d199a6ddf188c18d62f1b9e84ef98d7b7889191efdc71ce2b7225b84e5801f1"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b29439a4c029531b568c6f6fff95282c0256188785e91d3cc62a26d54b62ed99"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "41909e89e8c8f8996f195587ca2175a2543ac3e5d3db280e82dd81015568d1f3"
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
