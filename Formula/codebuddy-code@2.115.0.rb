class CodebuddyCodeAT21150 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.115.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "e57a48cd9ff8c7523d166a5e6aeb39f3333c79d121d63a89496bc0e45ba3ed6d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "7ce5ccb98fb40b72387492effa5355dff08cd1837dbad7cfeb4e14765c020761"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d58b711736607555db6e7892982d670a1e7b8eecfaacabc43c0e9c12026be2e5"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "cccf977f3d8f41b0425157839448bc3393390663ad31966dbd0ffa66268a4968"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "78a395ca6d862821e4610aa3e9cc030e2b7e32f5ea71375a4a4c000792430b46"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "96b335adea1055e0a61cc82bf84a2b7b6b3eca74abca392d428dc92310bf6c03"
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
