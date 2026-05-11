class CodebuddyCodeAT2960 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.96.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "874cf6f75d45147311b3dcc503dbc78f7ed26fa998a593c6cca5c487cfd1010a"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "9c867cf352df686ef8a3da18d459415b6fda4f6343e8a10f58b3f59d5193e76b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "14c52a0ca1d3a376a01ebd065d59b07eeb579dcd23a23305a38f61e785213c8d"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "921176d0ab93f49c242378ec7de8a766c6ee6020fb86e07391ce6a128b06e1da"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "3c283ac7c0429d9556adedf767e7923ea6102b341e8c7b10cb6103944fe41cce"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "7e184208ec9393daa2a4b17ad4bbf3319fee54d1a5a58a83961aebd1a9490224"
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
