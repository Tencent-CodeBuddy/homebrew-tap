class CodebuddyCodeAT21230 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.123.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ef9445a47d7956c06dc5c96fd62d71ecd5f3c3e2ebfb40c7596e521181c84d78"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b863f93aeab2c93587f32960e9c8f716beb7a529f354406d6de09a832f497e77"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2224cefb75515a0b50814375b7e52620d88b5bbb6123ee5ee143429ba5598b95"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "f1e9a4603bc183df50011edd551320a0843341d8c8f1644a3b67d4b0d059b154"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "aeefdb50a80590279c10d1a98bfec77f09f178775e52b01854e655610cb7389d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "3386db26a4915d3a6e21b6529c423e9b446701cf1a7dd4218942c6320a18e328"
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
