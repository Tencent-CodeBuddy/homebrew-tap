class CodebuddyCodeAT2526 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.52.6"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "51e9cca2d459295a6c9eca50fd0aaa2f94a495c5c27ddabc12718eaedf884028"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "775fd912736e0facad35c75cd943bfc33967ad6cb944374d2c25fb94e26375b7"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2be6077addd21fb2d8a06a28e54e6d26ad7d85d04a63fd9b3d4d164fe7a6d7b6"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "9b8cb3ce6f83972067c94690ef4d71c36deef1cbb5e265539ebe28dc8e0ea001"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "a0f5cc375b7a3ad49c2bb1f9f551b969a842519cff87acbe5126e1ecd941621c"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "db6f820d25b1fd3a920aaace80d72ac274aa4a27567489a3f4d1c33d0dd5d0a4"
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
