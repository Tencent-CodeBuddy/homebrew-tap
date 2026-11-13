class CodebuddyCodeAT21840 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.184.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "cd5a0107fde60ef861a0b2abae5821a54d543cd79ec5c4f5e69c29b00a2bec84"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "3c8fd5dacd1478f9a251767c3342ffd3033b8686679e71147a0449b7dc3bc639"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "8e3158e898b81742e02d77adc62e77b731f954b4387f8226c0035de469864b06"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "c325d8a988a61596ff32665fe299bf26053e7d212dc500dc0ffb136145273c53"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "a1f8273874d19b7256eb883fa54c80e21dd55528fb94435db7405acd79f8684d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1d780dc0f459d30ac0cc51153d04f29ab8063ec24d5ce39b31f82bb719f45937"
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
