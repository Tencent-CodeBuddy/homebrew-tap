class CodebuddyCode < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.168.3"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9194e1881675bbc8d43e8e2e58a1df063d169c5005a5341a36ddad8c0c94c5e6"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "37d49d34d026eca829c7feba225bc9d31a23dddb2c8ea03b9179128040f7c926"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "3468680f172426bb3914905fd535d3e5db05e7b62feeec8afb20318edbcb3602"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "b4a39f9ce9b5c405da638e0fd27a5c1a8f6ee70e8cc7df14f2160a13ab367cfd"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "e254fe261257a551cd9f3eb5b735b2bec00238283fd0836b0eef4e1c638b6d9d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "c959307a52af498905ac9122a6c9de136b8cb7ec36e13d7507036b22310f29f0"
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
