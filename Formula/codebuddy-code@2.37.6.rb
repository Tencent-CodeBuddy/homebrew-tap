class CodebuddyCodeAT2376 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.6"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "8d2ffcfaee9ef33b6b0728b4ec3175d246f329fa229bfce1dff12dcc93a385c2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "eb81d5aab346ed3c0a86f73cb47a5c1da4f510e53fb0d79f360e03d1c1529e16"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "cb381f83ae3f1576f376dcbc4c69cec4eb3a6d59dd02c9c3e4967f20ebea17ff"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "534eec51b5712774f5d8f3eddaa8ce609973b7cf1b1a1dc07bf3b78744a10465"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "68ff3a9f662307ce832f397fb20145e3bce494762a4c02bd1a195402cf877654"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "60de3d0b880cc3dac74324ee1fd50714f72995e5ad3e6b611cf708ce3597a249"
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
