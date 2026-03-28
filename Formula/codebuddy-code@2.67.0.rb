class CodebuddyCodeAT2670 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.67.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "d474ac64acf5d35492e7571035a51eba5da03adc17a645260e6bf0e6a86bc2aa"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b09f2e024f540d8ccab9f8e1a9de7fbd53bc3f30e81b1559af6dcfa5c9ff0282"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "16f12f96c5fa5f4a6f29a80570e338444785a9fc197cb098d9d7ba8f0d2f9375"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "bed288119b35d9b492bcad39c101a764dd16486c439c77c9cccc31b655ef4b69"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "267326e29e99cf5166c36ce78b6954739ac4fcd5e3cedfd8cd4d8d390d507304"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "0503505842cdd64ed9fdcd92137fa21d229f456de23aa24c6258a8c49b7d3aba"
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
