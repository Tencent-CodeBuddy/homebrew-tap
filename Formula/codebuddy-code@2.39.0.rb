class CodebuddyCodeAT2390 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.39.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "300215a7d09391b9037374598bf500d0b82b53edd20058a559f651e3186c283b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "166c2560de42c6a4c5eea41bf81e2eb17b8ae845d61c9f4602e36f63aa47f42c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "96c44bf68dc8982ed6ecac5b1197141028a02d10f85f3fbd13661c6202d71d84"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "aedcfc79246671b275faed0632b3b0c40ff3516250f2e895a6309fd697a44bc8"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "4397e19aece7c3ac70e997264df39df7b6fbbbec4d2528a62a882cc1beca78b9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "9d62e333fd54523da9db47c7829bdf29b3098bb1cae6bbd86968e70ea223f3c7"
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
