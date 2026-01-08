class CodebuddyCodeAT2301 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.30.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "6e85e8bbdfb7f9022c024ed9e912a041278241cacfa1926ed61ad4677ea661df"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "de0d1fb5e1d9e221cd05b3c691b0d84f60b9596ae7426d2bc25ecab3c5abb41c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "063ddd1466698c3ec8882981cbaf46da262e08048d32b8f0a1b09613ad53d7a3"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "5be3e36e144308de52ecab3ea707e8ecf4146dbe765ab090abd35675b1983938"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "f92516204860f14cba26f12bb9ffc5245610b285691f82d45dfd41d7ced351c9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "66778d8209f3f91d69e9fbb30686247836164986575060783d482a6151820d6a"
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
