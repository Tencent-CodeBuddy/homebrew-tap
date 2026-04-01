class CodebuddyCodeAT2720 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.72.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "74a5277031080fd7d2d66e9860483b2d6c0fa8d36b0c6bbbbd6a6d81b42729fb"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d43b3d7e678da7d7263ffaaa1226061f7f28bb8ffafed833da7297c194a8e14b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "64af74ccfc642f292965d60ea721db5637563589521af4088c0462f2af923708"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "f4fcd0cbb48e7f6b732368d70f4c2f05b02774720b86fbeaaf19cc79ece281a4"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "dd141b521567097255b56dcba40cb67f899f23b47a428edc56948867199089e3"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "d4be27ee1a4d2134d00ad3105ad5700afd6541c8dfab7b3acbddbbc86b22becc"
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
