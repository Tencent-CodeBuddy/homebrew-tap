class CodebuddyCodeAT21193 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.119.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ac43f90532fc5b6c1007b7c85fb9db3c488f47df8aff21350b2c1c10c4444a4e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "3ee10e697e1d0582d92b66327a68c044980bb50c311200a3a8d05cb1fa1c0ae2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "47716b698d67dcf1f01f8e2929570b9ab218d3c09107a7bbd6a984efac254527"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "22103f11a83b118617f0ef78391653ae109b804ef0bf9f3c694d1302e3bb9213"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "7a2ea5c2ea6f985a5080752944c1dd2af59f7dec4832d5be97d2f50a08500350"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1fc6bf667da8f68c4db8930911cde429b8fcfeb9e9abc6dbde7913a440f3c4b1"
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
