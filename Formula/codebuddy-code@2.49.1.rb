class CodebuddyCodeAT2491 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.49.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "391931a79d6d936f60a6c93737cc9ba641a7cfbd45bce6a5d6499ee68f0b1271"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "2aa5413c61a61cb60e5b4f76a86174d7707af86db8cfba0618e164e11b0dd03b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "648f2b1ee2d02256e440eee0e8ea1446b83b09e55d5645210b76ab19fd0ee2b2"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "b3dca913964b63e6f004b7ec4d1c59a749f1149fbf40203ed5f3b773fe74f553"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "aa249d4c5f5d2c141c3b0a27fd8a7e8107de85b024d1bf3d7fb80385b1dd19ed"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "b2941b4cd67306bf2ef82e20ca2086783ec13e8f5df6e48d11cc2cfe4056ee0c"
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
