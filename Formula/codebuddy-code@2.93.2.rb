class CodebuddyCodeAT2932 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.93.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "aac19a52f19cb69cfaa000245199df2cd3655368e8cfb8f02aa188d85c2a6fcf"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "32891c65e97f68bbc12f4556515b4eb0a51c9c3acc7bf19dc3df5e0c25a20547"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "85e5b11132f41dda1e41bb974392bc2a1c4e74c920496441cbfe99613e96fd3b"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "048364b5fc5b03e20f4cd5fa1ffd287af4b922d650f7222d49b18abf98aa770f"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "6109e94b61b0c12483c13d9eebace54bbad509d827eaddcd70de612def520a8d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "80b33c3be2ccfac03616647c17d70fc8190a5f3c238f385c21ff9eefa15a0360"
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
