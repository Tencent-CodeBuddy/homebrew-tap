class CodebuddyCodeAT2311 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.31.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "76bcea9b8b5a0a5780ed57e177c192d93cc9da6970ac7d67edb4dba43ea4b1bc"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b6c642ee6082b1e704ed56c48c6028d4f2c34c9dd9d60ad9dcd564f676888c33"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "c2482f39d853a28cc70fe97a5e9628214a9db2e599984eb122a08d9d07ee05b2"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "9e908e3058fb8ccb4515f237cedcc4120ac5392f51ec2d362df082127c3fe64e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "a0bfbfca3f06d1489af78e31a3575fa8dcf993563d6be434cd597ce1de9b8d67"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "3477d02b9cb89c66eeb63bcb271679fc245a9f7a3dce423aaaa7b561e8a1871c"
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
