class CodebuddyCodeAT2791 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.79.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "32b5a12c94168fc70ba3b4445a4e81127abd9be1c1654443b2e28c931cf35c88"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "07dbb80235feb204262d3317793fcce2006b315357ce1fef7b54314c9a36cb56"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "e82ca81b3e9d003ad7a3684de81bbdc0afc6447aa09e3b1d00a75afdf15cfa01"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "16e430735ed1a33fa1ba88234986b822c9d6b0c817ad21fa614db7d97cc16262"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "1a24b07dbd9487e3be49a99384cc53d30fc82a0dc40f449a73629f8717455066"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e894b5f866c2d30b070bb780d84c22bc0dadde179ed4904c1e32b0557a12f7b7"
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
