class CodebuddyCodeAT23714 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.14"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "0c7acbe9c767b3de4760cd40d5a233ffad12dcd08216448255f7ca405a776d08"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "44304195c0df1dd103498e90f4507595613b7b4e2163fe944a2e15c7119eb80c"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "44cf2e6c97950ecf1f15d3a4e9fadc3bb0aabf65417ce1f10c10fb2c340860a8"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "f9acf9a98f5bdcceff91b0cf4d087cf19085c00fdd33ec5fb265af16b86d7e71"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "99183df94ee27ee5bc3fe7b70d760e6d49f300b831c7610a53ac8c625752bb91"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "0e49c393c38831dca5298ea942214e1c9df1486ce624812211b8791640028999"
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
