class CodebuddyCodeAT2523 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.52.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "1cc8b8521e51142d7682d52235fb5d8f95b7b0bdb470cf2c1bf607eb62cd05bc"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "aac251f86fb250f0fbb17a3af87bb954ca496f0501b0de18b1bb16cb103a4b7d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "181347bf467070cf3a8393a4e0a21886026350fe092f7a7fa4ae2ae03eb92d80"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "4e539bc0da9e051e2df187fc28ad437c8e44d5466049a0b195947dc7d0206325"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "75f5cfdd3cb5dd1e713d332406c1570d2cabbe313154f2d16a83b94bf95da973"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "2b8116744284b031f3ff86480a542a50eb50067b6747cfedc5860b37a89224ca"
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
