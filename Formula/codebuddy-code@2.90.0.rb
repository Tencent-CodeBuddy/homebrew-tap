class CodebuddyCodeAT2900 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.90.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "65badca231cb78bfd209dfc2f6038c1bebdf6f8b90525a64e3b40ac5e6c07de0"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "2b4deab663dd2049b8d2cab8a78ba0fd745452d81f4add8e0e2c1c46a5f3a111"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "1ec0d3c3e6533afc6f7f83b3a4e22f7bd6e84b3676cbc9dde4615a822e83a552"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "23f66c4df98077dbf5d62f746071bb6a9b7ce6c192ef80162dbb975fc5f43fd7"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8debe5d88877275bd755fd6d1dd5fba1129ffe05c56749ee2559d28b07ede501"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "930bb376ce4e1dc96a104f32794d1b36333d843c432cd1ed9a2977de66247e47"
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
