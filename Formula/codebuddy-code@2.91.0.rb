class CodebuddyCodeAT2910 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.91.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b7f5ee048800bbca59792e56cc04f2266d7a58e989e79b9c7446ca5e7a8e2cd2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "9b31affc1f4309dc84752cd3ff98ad62f7a4ac6184418d92e575a19135bcac43"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "253977404258ce6af48eb2cf7bae969292813401acd1eb541ca7b7cf57b7c9c0"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "1aefdcba72c232811f3820d3a5ee029a500fde0d6176a1281e3194c7c0f6c205"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "3487aeea016e9aa153bd03a6e2640d147ab846122bcab96d06cd5486bf6df67a"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1e6fc8300fe2e7adf98879c6586a38218f19040a7361afc0a4b124c450926528"
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
