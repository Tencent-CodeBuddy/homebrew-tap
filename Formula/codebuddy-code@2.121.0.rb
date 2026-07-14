class CodebuddyCodeAT21210 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.121.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3e42e48b9dcd58f321907ac9308f8f415fe47125bc918d500a084fe251d3f7ad"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "c243f6ef91794469123286585bab828247910b4d7a6567c688e07d3e3a8fe1f3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "28a5c32f5e8bc6000124ac539d5f75ad5a44a9709ca563011c3e03e59aad7b10"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "fab6dd8890a94eb121770d627aac87d7e5831e43e1ad5db273a81159ee475d18"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ef91c780771d654e6382c2720aa3a9bfa020558ba3af654f2b77b7dc8e3cd426"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1842cdb20611a66827c31f8acb7ab190bd26da76719158f1309b5198a5336c44"
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
