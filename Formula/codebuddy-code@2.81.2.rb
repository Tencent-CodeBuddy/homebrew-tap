class CodebuddyCodeAT2812 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.81.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9dffa51c6186b926388814071fe4b713636342aef93cd7f9a9ec1d2fe4b03f61"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "584cc6fe808a1096df631f5e617be0d49ded460bea7cbeb4d62723d4444e90fb"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2d6df4434e460af77a75e865dab63d32effa58fcc56b52b611943aafee79e7a4"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "4e339e288c6b6862a255f039984e4356fc168565f89d4f3fbe4e6e9d0c753884"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "78c59962179e7fbdd7f766755f3892c17ad3310269b8c5abbad0255b80b94b43"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "bd10a3fa9222bae337a366a5a4cfa031a715e245d3d5e8326fd69142dddf8dcb"
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
