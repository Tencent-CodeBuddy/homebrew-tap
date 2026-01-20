class CodebuddyCodeAT2373 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b146afe4a2aeb3b8c8a570369e0e675fdab6eaa1f35504945caee3ea65cbff8b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "71c9af4adcca2095216ae9a43eff943eb675f1d03d2a8ec38f7b532c9b599632"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2a5400396038570ad567220edcb74c06eec2e3a83744136ea6f3075e6d8b6065"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "874b0dde36cb4591fdbcd649243998bdcb47796867c7d96c5b0a7e11be5947ec"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "40c3e9b2f9ae0f9471d1e5627a41dc08e88ffd76f9ae17868ea40331b12fb623"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "93a5dd954324c0732f808c7da2bbd15e82c975c938536cafc9886c193e57319c"
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
