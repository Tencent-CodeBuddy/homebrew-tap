class CodebuddyCodeAT2371 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "37625fc9a65f9a85d2529cc18e56517e0f4b9420f457c791df1500916d6b0793"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "972dc62afc8b4d7b9952f7f19ca56ec44ae8601c3d62af6ed9162a967d7ffeb5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "46565c98a6a2adf6bfdcd59c027dcde63b85ed4d8efda7962e0d93f74f1c4127"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "353979abeb17e2ac20154f8b8d2ddcd43114a1ae027e9a6508fc8b8632919a47"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "407dda55bf447c77c551a9003ecdbe448b9d88dc8c33712ce74142ce27a14947"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "40082819910956585e44c95163c654a8ed4f1f71de2b4e072da2132286e1e93f"
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
