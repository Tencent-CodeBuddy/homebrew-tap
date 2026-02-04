class CodebuddyCodeAT2460 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.46.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "97d3959871bff785903ec20882426b007f7a2efd53b85409bb35b0b3c947c5f8"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "102d45b7c69f1b913be0988bd8cd8256a8423c7798d9bb784f42e6566f8ceaa4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ce73ce855f12f51d1d3884c961cfb4e88d5b2adfa15c4fd5e5dfdca67a20fda6"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "e7ce4270996b68fa48166389f5bc023e5d368e638edfd78a229071bf9ff0273f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "e0023f3ad5c2e6b6a585a1c61e539d9b3c45ba99a0a9ee1ba92f39042990edcb"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "b27f37de2db1e81afe2406c12ba782973904e86ebf3ea3f3dae05aeb75737dd4"
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
