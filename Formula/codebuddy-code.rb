class CodebuddyCode < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.177.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "665ed2f0aabc17cd837bf6a89384dc5c76f68e06db59a009797fe6c518f583d7"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "03667892756a8c7c7b476a0cfe3a73be621f218d3922da744e78fb091e5ade8a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "402d574a16442b034a80eb244409570090bee99e23e65c59a7fdb4112901d8f6"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "6862d7a4569cfd63ebadfc1dc7515583889d307bb4dab799b1ebbb71bfcb27d2"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "f7e44dd0de796bb33d36ae5c99c69b32120703c2b43daa860b9370646befd227"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "57d1dfd1c61aac8c56350d0a492ba0b0cf33e9c7c46d75f4665085c304c79f3c"
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
