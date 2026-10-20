class CodebuddyCodeAT21710 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.171.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "46758c8367804468639e82f95ec796fcca3f2e90c9096bcaf990694a0bfa609b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "348de09fe4a4d181cc39bf05fb58adb297dcbed7e7b75a1c2443fdcf011374da"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "7ac298ba06b010ac09292f04a48df40e116872646a98d3836ccaa71f17fa01aa"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "81558234ed74fa9bfdb0e5d709030a9b57e364e39e0a1433367cb4f7d397aa86"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "6f1ef766f7d330b514c7b2d0844005837573115cfe0f1f64c1ec4154ea4367cd"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "67b79f08ae1f454bc40cf4e467be3eb0b22ee768192a254dedf6f70fd640604e"
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
