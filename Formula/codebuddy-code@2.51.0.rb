class CodebuddyCodeAT2510 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.51.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f963606981fb091dc63a9ca6986603d0cd73ca70b7271709f70c0abdd1d80dc2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "a3b39dd55660d8b14cbc959a9fb7cdeb3130c531fdd854766981c6cae6e819ef"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "36dff94a2093f39b445a698b2b1f89ddcebf086d5b0098f29c31737922b986ed"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "0dd17c3fe71d3ddb29725faf4f1273f12b1f38b2a0556bc7c89d567d75841a9f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "0625c891798111ddcf4894bcf814a45685bab53d22954b01b3e01903ec87f760"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "67409e83079178e7d7ff08b83c23d1775579e3ddbab1aff63790373e7253e426"
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
