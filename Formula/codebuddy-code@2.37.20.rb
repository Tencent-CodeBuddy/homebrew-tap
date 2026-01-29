class CodebuddyCodeAT23720 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.20"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "61ca383df501d724922f5af17c01824bb3864d30275789277d847d1e75d84cc2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "7a0c65e61e2424989f81cc262d280003e58df4b0ca885a0ec1a39374c728741a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "3e559d106fd85c0033f5b7127e0a71201f60a1eb7bf9a4375c9c6bed0a33b7df"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "9fd3b22d844bbdbc32f995c372e4315b67116120d0ccfaf0e75a2b4cb1ff43b4"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "5663b07b4ad65347d0daba3804e9bd9dde7d92782b4e57933aa47731edad0122"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "a9121066ae466ac4792545be31867c6f9007295861953ea5500f01ef88f440fd"
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
