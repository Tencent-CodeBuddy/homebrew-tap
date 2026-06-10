class CodebuddyCodeAT21052 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.105.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "32fea60f20032171eb660ec9651314ec9bce1108904c5b825fe0c7423298188d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "1b5571dec62e68cca4cb8ec4f84a4a59223063a66aeaaea5078cb6405d6d1dc9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "0e561a32288f5f7c6d0869e2c379f4c34171fa678aa5748af4caf0706cf93d2d"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "da6818bc3bd21a885115285b919a171a16b0391f48574e5485ff94b3a4eaae62"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "92c56a436098847a398d61acadc0a997006456602fb68477bf27b6d77cdecb1e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "d4260a5fb2ce3e7223a14f9261ee15e55ef05e5e2a74d7d1de5d97d98855825b"
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
