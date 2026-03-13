class CodebuddyCodeAT2613 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.61.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9c0f257e6162309c0c1374a0d121a6c5a7e8777a07165f72e46c89d47c550112"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "40de478b86bed5f41abbd35d95eb6f1a97792ee7a5b5a7e709b8a2f6843d3784"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "02cb2621a73431e29f725800ec1e69b963b4b9358f40327cdd82cf9722225aec"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "120c5a2ca5c318fab841dc5291e279f3eadbcfa0475cc069321026afb3185a95"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "a4bd0408cd0f48802eac407222d9f4256052df8c63091e2c3311392f0477fe27"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "7481b1a19462225832c69f1e8af75e1d97b3481d4b09ba0742e6e9ff1ee3b639"
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
