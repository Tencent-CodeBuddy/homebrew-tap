class CodebuddyCodeAT21620 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.162.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "661ee8e81ccc7d50e7ac736fe1f2bc5ca89e1f5dc66254f07fc97d9c27ef8767"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b925687f3ab7e9e2d86ed5c466ff558039f7f10ad8f92f07c06f6f4634942cab"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "e55392a9de2d7536cfb87b9a2cadae4235b49c16042b2b4dee7a8ce390271328"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "d5a7fe86cfaa4e1ea746db92a4eadd2018fb1352a045bdc947f9331190f403b3"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "e5666325bcd17161f7b882fcaefc1dfe53773e6947e604237beb7c9850f68081"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e4689d5a85f6e669174e5a3e58fe9cf46b249d1478a6e85cfd572e9f8ad336ba"
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
