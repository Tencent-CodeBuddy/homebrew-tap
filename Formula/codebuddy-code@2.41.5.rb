class CodebuddyCodeAT2415 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.41.5"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "8e487726ef513c6880d9efe23d221c84e1191503a42fdc22f4ebe8591f258e5b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "e3eaa4e1c69a83a15f7b106ff26e1c1c2150f574c915bde211561a86510c020d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "822ee5ce1bbba22f7dd276060c2004f634812ac9481e5ec4a8d401f34ef1ed47"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "a859b248d5076962ee4bfab35c97975dcb4ef22cd3425d7d52a3af578c52bb0f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "3fc210db65f1635728c52960a700116073a2fa2a7212e7c04d17a9ccb8b27fd7"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "29d58d0a7c6c7393cc55f4833c18a5b7abe046725754bf1700976711c788ea50"
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
