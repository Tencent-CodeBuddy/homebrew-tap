class CodebuddyCodeAT2730 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.73.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b0f62b38ead1c852beea6c1f4ea483c74da8f12fa8e6c9a8bb5eacba51e373ca"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d1328274e3a0c607a697df91cc6247b081b5941627a6a84b5ab3089cd015ae65"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "128cefeb4b96694ba4ee8d0ddf13313235e53335437f83aead2489e8b5b857ef"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "aed433956e62f669f6fa77efb9cd6404d14ebaa731ad9c577aac7530bbdf001c"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "597d1715ee9c68746cd3d5f335af0d3b0eec2742ebf45ba8cf10f71755d2416a"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "38b5f8b6af94cf0875fe7fce1171badc2e3948a2be51bc71b6772cd71a49a1d1"
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
