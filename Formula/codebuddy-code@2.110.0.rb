class CodebuddyCodeAT21100 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.110.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "72f960d563d726aec147d33b41345009111bde1c8430b75635b45be67b0dcc23"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4a66f17ecc6ec1c8f303b61de3506b3dd1065f09fae66a3df0cbfa8ac045e43a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "a21fbb04f947830f72b098e36bb6c3e1de6801c0447e620db07d725cfbe5be47"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "ecf52fd10d87054ada8e9df8256e68cc2b9e418b30a92e0e6036ebdca0956675"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "e874eb96541b4ea54e460b219714092e36d8df8280d941bde3be6cee28ff611b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "5a19747e681c8ef135ceca15ede3f237eabae0f3036dbe3ae84bf2fd6cce0814"
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
