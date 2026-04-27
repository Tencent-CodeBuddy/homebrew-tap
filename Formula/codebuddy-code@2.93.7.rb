class CodebuddyCodeAT2937 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.93.7"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "cb67ff43a94717b72982030424c7fae7d8b3c513880143c49ad34ddf65ccc7a5"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "19c897b230b976ee3e086504d2771d39be817a2dd07ede0f805a4e845fbb95b5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "00a2efacbe2f6243e395fe9349f6a57ec01f0c0a354cbb58616db5aadc16c720"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "a28a85af6f9876fbc3d0e1d25a2db0e457ab956b53fd6465cc17211e2a70a6e3"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2928a906d727e447ff1bbb537f1b93a5e0d8744c38822691e2d5510099d9d606"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "9b64e27f7293119c32df33b5fe1b778b432d4f95280a997d31a6cf9bdf1154bc"
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
