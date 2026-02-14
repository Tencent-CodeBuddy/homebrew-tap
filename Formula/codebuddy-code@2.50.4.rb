class CodebuddyCodeAT2504 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.50.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b2d9a964550b0626597b35c1793310fdcf515b3f1e57288f694e191a23778d49"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "7bae20e34e80be69a921ac3fc7ef89b12a84799e3ce77a6748ead187b05d2f00"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "9b298b64d8624652fa54c2901d43697aabe10de5a6f050fd9825fa5648eaa018"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "65c7d3483a411e7b41774823451eb6f971cd6808fa716408e0e12c560f04cabe"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "10d40221a61b2f502aa49e117557e963de9d235c06806b3e34892cd1f76f7b9f"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "35274ea722eb936b145cee80da00bc673833185362ff5440ebcf40ba660d2de8"
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
