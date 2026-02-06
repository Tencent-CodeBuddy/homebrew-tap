class CodebuddyCodeAT2481 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.48.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "be089741bb36a9cd1e7b53fd2aac9067fa1ae384b6600ee82dd9d5eed2e759a8"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "a361e5cd5674f8c86d253f36305a82a51600a7e03e5ca0ee68e55309dd87cb20"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d3c2926280f285689e022addb8ebc7aa73088787f72645bf75d878a1f2921f01"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "a634f702d9d67e8d2adc10e4908137fd94f2d586433592a1e2223f2b91253019"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "5d45cb541c6cf7e3331fc15b8c146b3dc32b2260692c96b1675e4b1e47de6c6e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "07e81204b78c3cf663ef13e9821b3c5fce837aab6e0e439c60544c6f5b8c23ef"
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
