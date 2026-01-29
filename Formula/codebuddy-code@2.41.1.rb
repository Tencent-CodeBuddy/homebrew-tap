class CodebuddyCodeAT2411 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.41.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "e8c933155b0904bed0be5d8d686f27d2f6e8f431447a413d92442dfbc9b012b5"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "ba26deb5dcd099e77bb907ebbc43f4d6f4cdc2736c8b9ad5c281cbdf0c0b7fce"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "129d033aea0c67e76bbbad4d5a91d74e5da410c656ed5dfeb5578b7f88675164"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "856aed061f4dcba407338a4a6d2d3a48eaf8942cdefbe3a9265eb24e87288e96"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "db3743f70f62f4210665220f963715d5e11402ea51d120e8fe0834eb232e11e9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "fbaa590341b97c3914eb6ba97a5b2c04eded5a6f87643af9e90a33f404ebc3d2"
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
