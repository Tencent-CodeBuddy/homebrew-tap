class CodebuddyCodeAT2320 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.32.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "920ae879556ed6f89d87fa3bf3b299fd219844af1ebd65ec93f89a175385a0b1"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4e74d265b394f2bb7c5d2ecfc9f5aed2725eaf4c8ced6f5fe926c4bc19dad58f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "1399b0e7250a321bfe104336df74d7073302ab57e0f50919cf106a430434b850"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "70efc9f1b4554038d6e85b48625c913b6c521dcea94b3ccce646d7b7d586b733"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "13cbde7ce140a27f379d3f991bc716534ae0961e712d5fcc2d0536e7a6ff2413"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "37e0924a9633d5eb4ea17c0fbe5fe863542ecad7b85561809638659e3aa50d29"
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
