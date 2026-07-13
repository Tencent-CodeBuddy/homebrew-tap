class CodebuddyCodeAT21194 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.119.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3d32816c3b12238c02606e4d4833cb1a8b0cd41ad0901156f4492d45172709a1"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "7be963c070ae24a7dab42defcc4b01a9ba85f8216bc24d4f84cb311276f1e5ce"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "6e306ee6b4fad07bdcbc25d8020c1d23753aee99fd1ac26883819b43580d9d16"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "415dab944540467806a4a06865f1f4fa71cabbc5efd5fcc317ca2f0fd5de9a54"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "3100bb0cdb6273da55f821eb45e1d0d911a38439db628ca18c5e5a3ced839958"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "53836e7454c5760adfc3fbfed8fda50f9d322c5aeea346fe314bf6e8c70eaff7"
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
