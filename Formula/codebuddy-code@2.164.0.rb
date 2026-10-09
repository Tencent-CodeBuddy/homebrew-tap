class CodebuddyCodeAT21640 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.164.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ada40be6abbdbad7aec6d3a1dc4ce968b1e98e702bf9de48e857b6cb996f956d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "a815e7fbc6651701b282fd54036b38b0ab215c811f0c6bd5302dfab9e05d6091"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "aace3c22decd81a3e42a4942b8176750e5cab71265d158acff2bc1d2d247b4d4"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "510b3b9f0e8b5f5b64cc51740cb131f1f64e439909d8dfedc1e0067922bbec3b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "aec19cff8e5e94e2006fa2f4a8576f727f3fb7717b5811aafadf172923379099"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "8ddf97b68309bb65cd721a47b8768a13538ab2e33c640df1d66b4f99a972f5a4"
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
