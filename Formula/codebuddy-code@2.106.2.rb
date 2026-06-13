class CodebuddyCodeAT21062 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.106.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3361e3ee2d204b95d597de02e6478615f4ce2cd6c48d026eece73c2fcfe31de2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d4e9f16e55973416593a34d6704de71053fdd0ddbfb54b6186f502451cfab059"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "f42739ee970202cd37c416f83464dc9107889c0a69a391921097ccafdac06210"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "23fb67b1d2ec0539758cce0cf916f7d60e436ab2a3f6cfe0c5aeb59bee6857d4"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "d6bb05611d708234d1f25e5f5f00d5e5d2495dee3b52e101910346d261efa5b6"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "feb6f941c5fde4340decccc82f005a162941aaa89ebc007e0ed4ac41e23cb2c5"
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
