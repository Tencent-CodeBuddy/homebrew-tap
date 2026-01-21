class CodebuddyCodeAT23711 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.11"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "4cedcd541aa5fbc905f152f299ddd88c504f0a8258d2cf3db4dfce4acd6ea091"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "8f1bb3def4f7b904ca84a1ee30f4a17063a685b92031f4bb7d1e5ff0c55b59fc"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "7bbeaebe340b95af7ecc993819e3900c4c6cbbbe1f32174f17ccdc77eb67af96"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "8e7b7a9b2d28e8bac95771470d75ad09bf17382b47090574396d41b10d5a2a14"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "9c79b6731c617b6b77497826cd608c54f2cdb1c0fe51302c1a5071786bd34b03"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "7e61102bd15fcbb2a5da0c7474727d18ff4c1cceaa8eb00245bdb3a9c1f14a2a"
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
