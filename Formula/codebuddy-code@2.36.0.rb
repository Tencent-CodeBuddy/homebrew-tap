class CodebuddyCodeAT2360 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.36.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "a3849c1584af2211da64ac246af8a847bf88ba384276db5cf066d57c3327d515"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "8c6556cf5a42f882855fce727c0f579a2c99800db09e0f1eac9b21cb02963be9"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "1ff9bef4a51a0a2fa5bef1a9f8af3619eb48801b0786759ef018ea1d4d8fd250"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "101e05bad518725a34aad2913afb7c3c54a1492cd1cbff6859ae7c846253f42a"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c80f6b2ba00507181c4bc8aa9b48a9ed4321619fd166709c10cf219c800ed9b8"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "4a79bd962c93123cb0af5ae43187418241ab942be2a6f31ecac681ec7c4355da"
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
