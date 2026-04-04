class CodebuddyCodeAT2771 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.77.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "94c5173422518c56b323006c303fed3433d4c605d3684898a14bd5baba56877f"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "2b13373152fc162c1cfac2cf7188c5825da31f8663cc6523569821440233129e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "83cdac95fbf8dcd81d04381f9ef5d4915e328fb704b5f2ea258c23b7d2ca6a1c"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "c5dbce269f8fa379065c274edaea25ee63c1a93115a3401c66558e18fc7fcef6"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8a1753af3756ca376cfabfcf8e16869ebbb8bf01cb574eff0962005db10733d1"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "bab487117a3d14b76d1c5f4af480b72eaddd41ac51ad9bad1b415b73d45e43aa"
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
