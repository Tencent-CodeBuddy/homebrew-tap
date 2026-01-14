class CodebuddyCodeAT2331 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.33.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "e3839e955b5e4624ceee453666d5a1023a3476001dfa3291f11d572b72585376"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "194da1e98119ed039a9272459cba13a3dbe1ea703d78de68c95ef880a099b57d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "80e6c28000c1b569d49483915075a37a67467f91925a556da8fdab33a6eacd6a"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "437768259950b6db038d652f938592530c2cba3e81f8f28ad13c130ecff666ff"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b9811b4d3d1cbbd094f788ef8ecb3683cea71db7d26a55e8e77915dfea9854d5"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e0fe71c846c673b63e18e8b53380ab751b2bc2857c43c05bfd3a09fafdab91e8"
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
