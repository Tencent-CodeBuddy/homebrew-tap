class CodebuddyCodeAT2300 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.30.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9dd7d9b56b1036eccafac0ca1b0420ff1e5990fca6ca45823f90210a92668f48"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "fa9ec611dc51785093d224f34eece3ed8c9451af2d532b266e122fa0cf2feef4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "96917663056c85ff8f244d1a7d8d86287a7b8360580b087b14b84ed252c5bad5"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "1a6714f73bad31c4acce99267334e7e632f1a2281ddbee2e851f391372653153"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ade087f920e4eeb9dd97d298879616e7974a6df8128941a56fd032b58e5085cb"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "b8a60b191907cdd676d743cd6a9102dd70f447885441fe23c21120bcf40d0dcc"
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
