class CodebuddyCodeAT2830 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.83.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "42b3e7e614a04dc9f4d2d5320c4f542a59787e2c3930a1ea0d72e0d851c7773e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "665598c29a49f1a4390f39797bf45028dc44170bbafc4fef6a2acafe5f9022aa"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "db0cb8789df830b69312cd194dd4e8d2ef44f4d6b4d40c75c240a3684a2506c7"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "47d04015c508b42c4bd8c19646ff990c4471bda657eb56ea528a1035a8a85c82"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ca9f47b827a5eef98571c9bb0e587c0d4c9db1152c368f7959eba1e8a8a9b244"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "4257c9d8d2e1e2b5af8a8b52d42fb81030adec5e8b560ab3abe980bbeef6ac8a"
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
