class CodebuddyCodeAT2496 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.49.6"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "12c2bb2238526f4f3c775bb883647c038c51c008545e8d7d63e29775b6e7e2e8"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "e2c3cf061fa18ced038ed9722e5ed861b7fb8772cb261f9b8d28f9ee60ec469f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "777ba7da78758c88a956b7e228a62cfff548149d8f27edfab34e146f8a78483b"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "f304dd5f811cdf3aa1014a0f16d0e0a8b7f6fc53abceee07494589288fb4ea39"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "032c727f361512b51a49a6a4ff73bb199386f5f62c1318720681faba095925bf"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "20c2b2da53629868eaf7a81292e7246596feb89f92ebeaf3ce7e5b4a8fa97cd7"
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
