class CodebuddyCodeAT2930 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.93.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "202b8baa8ec52430c4035013490e32d9f93efb13959e62a0b2fd05f5c061dc74"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "c8dfd7df7c0bc807b796e52853e23cc38223da0e0fd017951df71fe7bd4323b5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "5829371642006c1cc8ceb518ccd8fd436f7561dae5fa8eb6122c25369e9f25ae"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "0fcf3cb87a1e0810e7b40989ba08ea27af823e7586b2ee287d183ecc0b95be62"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "369eceb25255469671abbc284bf4fe46129ee5dcf90ac59ca0b7e96a98248d69"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "5df8060abb81a64fceb1ae8cb5d275cc7fe986fcdaa4f9d053a540feddce2aa3"
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
