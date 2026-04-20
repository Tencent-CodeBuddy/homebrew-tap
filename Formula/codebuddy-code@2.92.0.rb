class CodebuddyCodeAT2920 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.92.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "a4d5381b7603b0e6bb08e3100b646f8628fae7d43f5dfbb0a00c09130282017f"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "66cf4d57dc4abeca581070b89b18858cc3c3749629f245eb3ac43c24de7423ae"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "80e631fc91f10d81c94932a0299eb8efcb4ccb1e263240a3ff0012103b01c23e"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "554f817a9ec3e27d06459e77e098e08dc202ba26e8a29843a634e7057d96a5eb"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "68557cbaabb0e06430151bf87c550d1d570f089fa1f78eec357fd01f82423e7b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "8c9a5eff71e61033396286574167ebb2ac04366d991f3f1de2fe70f09200d7db"
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
