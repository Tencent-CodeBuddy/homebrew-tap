class CodebuddyCodeAT21791 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.179.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "524f8b3b1aab0dc073b475837ae71ffa74dc679db78c8aa2a3c830fffa7467ae"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "0f7d0ead53d62b0dc76ad9c5336e8667054454b7410e3f49e9074f824ecace17"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "bdbf39a6db22284578f4e27350f4588c9d68ac50a6557b21d1521f150ea1eef1"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "005d03bdf676bf9c14e81fd1ee9083939f1273396cf9900356a2fbfbbc7f98c8"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "f0e6a6b42f78f8cc462071db7bc5c8b31ff11ce830ab59a1a370c94062c28c5a"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "6d032c372414d89e905b1210d1333e078224f8fe894f0402299079e97359b930"
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
