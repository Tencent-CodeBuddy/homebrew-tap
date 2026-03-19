class CodebuddyCodeAT2635 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.63.5"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "8df273c41c181189773214fc7cda96f44ab2eb975c7857465b9601eb58611127"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "e9fe6ab2a0a70658cba1bcddd91c532378e87677ca8c2a664b24daeeafd46f7a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "479bb0fd6c114302ce9fabc797ed8487de25c60fd88278351235fcbb9bfdcfb7"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "f6bf6d1c1c40216d2fd8e79fbcb028e0c68a07da7678781379fa1dee88a8ed1f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8a4ab91de51fa97f7a69728ccb55bf588a2cc33ef7d5970674b4fcdea92e62fe"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "6d5720f2e188c731b0e904ea27671cac9395f5632dc1e9e355009814e50cabad"
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
