class CodebuddyCodeAT2950 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.95.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "4b9cee31ce228d18e0f66a6fe00e91c2a13527a1c5d81526c4cffa339cb93067"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "9303bde8609be7d193f0b047d9971207dcf6d9b2ac6059a5bfb6711a32c400de"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "9df3770d3c8977d7af1e27b3d39e9ba0bd581ab970cd0ea271bf59e1ae3882b0"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "fcd2b340816c5249939e2f520083f3123ed16228f71965e442880ef0e6407970"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "98ac3b55d79a132ef99ded1db16250b8fcfc9dd16cab118780f513a7de84a046"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "5110bdc98cfd875e796a244c833c840592fb99a8afcde051b5e79293266a3bfd"
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
