class CodebuddyCodeAT2800 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.80.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "32bf0b608b49cff8163f572d5aa281a113c77fdfa63997c0e86a1391c73caadc"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "2163570d4085d8c238abcfe9eb86e5197679ba61a69cdd0edf9958b7b40f4539"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "862f7a629829a3e8336c973bf5ff1531dc10b0964dba205be72fceac25c8c94a"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "729b03aeaf355e24b4e3fd5e3ab71fc5ef0b9efffb3362b045dc996c4d6a7197"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "1f9d5d1dcbf8c9ab4a35868eaa4cbf4f6ad0eac84e62044a91d4bc234f664fb2"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1262b7cbebc9017a1cba4cc40940339117b87624935a3c4ccea5068053ca9c79"
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
