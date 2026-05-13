class CodebuddyCodeAT2970 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.97.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ddca0a51945f6062f8a0451f3314383c249a9e747dfb54e972ba9e8a8e374b84"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "801d46f52404b2cb632a7550581bd848a703b2497e8ad6da4f351cf43589ef09"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "9fdde88c147bacf0db2b7750a5cc7c2a71c036f021f6bc5d3ee437d1280fa6ef"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "217e17646e0cddb7d72218c433a61fe14ec5193cf42533f02918b733709cf386"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2b2ebe9bad5d7125a1e03c09b50c8174b40dce55659aac9f83a5d294b48e3d5b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "7a479964aa720bd4f645bffad2d55c0b5ffb162e31f2cbd371e68de07f09178d"
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
