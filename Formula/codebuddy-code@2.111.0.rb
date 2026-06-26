class CodebuddyCodeAT21110 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.111.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "7878568256ab04b966e26083adcac1749a99cc958c64d87076fa4f96bb4f2290"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "91bd8b9880c83bc9f3130edecf6226327f9e600b56210d867f484bc491d16c5c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "49632c663d5d3d1fbe277ac2856fa76ff18fef6bb39ddd8983de48f4c213e0f4"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "7d565dbcfe01e5b2a3640b3796a063a9c53921d0f352b1b8e78a797d0991e45e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2333d1d9ae292884c61ba901348c4cf8e0d264a7e637dcf4569661cdfc8c9dbe"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "f23bcef11dc8f18cea3380ca8fe364b889f5a4d8a79070dddf960a607cb8b2d5"
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
