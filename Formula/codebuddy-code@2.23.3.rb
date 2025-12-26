class CodebuddyCodeAT2233 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.23.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "5c3aaec5d046d8f2099bc3ad91c961d971285672f39d34559890d900faa53cee"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "526b0c2143fd9cd28519ca4df616d748e4af72c02a1dfedf89f30bb396e0907c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "300d774bee77082c69567cded4f47050719f7285dc5665f2990dfb5296b683c4"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "3be85c9995e9300ecd4a2532f7442a559343981d28f775c4bb73f07a5bd7082f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "1d0c77da6de6c8e01cd1849a08cb714a437d31987577579560c10ddb34cb79ce"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "bc33fa0bc0ef1f851dce56531885bb4eae9bb58e0078ee291a49b54a01c30302"
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
