class CodebuddyCodeAT2420 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.42.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "edb2cf1463a2f2109529f76ea29c1e8475c721679a2e917f6141dd1977c372ca"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "4df662fb2493d0b5463c7eee45a4af0e7bc23328dc861643d4eb613bcffc4e3d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "43dd2bbef55b0fb9d6d61344fc0aced2bbec4dee681a047689c3dd97cda9e6c1"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "7e5a92f557f4b1260daf485aaa59b854a967f125809763c205081d044ccfbabf"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "710859bbbbcc0d4f3394b6e09713ba30485d16587f24ca61cc930dbdb536dd4c"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "a52a1ce81c9831441a683fd0b42570897c54717b8c327931786c470cd160e522"
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
