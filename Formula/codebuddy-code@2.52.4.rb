class CodebuddyCodeAT2524 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.52.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3cf99ff428e51c670134993b8535f81f719d11c28a11812fe790bf95aba48108"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4dd4381a9054f3807e3fef177c35f8c2ca3c45bd8abdb664e9fead10d95e7a28"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "edb4a589056c47ac64d3aedc3aa631213d3ef07a26e3fcde05a68ce244cd8914"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "d9c96c5a51244696b385c39ed25e76b2a10ad57065918ae9e3851f484522c7ff"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "9bc799280dc5c18c6d2dbb96a208b6edf8cafd587e978bde062675f154135316"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "96373ec5b0b27f132546252ea39d0a8ff0b2f7e4bfcb039cd0b1fc00bf088bb2"
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
