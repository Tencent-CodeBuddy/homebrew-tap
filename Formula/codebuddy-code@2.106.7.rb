class CodebuddyCodeAT21067 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.106.7"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "704ef79d20b19ce9ca0040dbc169b14dbf33b44a6ecb7af26389f9cf079b5aaa"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4082ee42c217ae3e3fe89260f79142fbb3777d075fc1d503eecf017ecdf3f183"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "717b8082ae8f309c3c13e3dab43bc37a875324699c0d525e3524e48ecbea769e"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "c35f557284c33c9e0a2939ec34c1f82577e7ecfd6faf2bb0c3e4f920e5729d2e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "0ba57f4b3f8987d3f87f85dcca57f3a5c2bd1fc5c25e63d1be9a2b2b7c563852"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "b293e405b6a398f8b79ce6ddf2cc0cc96f9a254e1b20ba3a919060f5dc30a988"
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
