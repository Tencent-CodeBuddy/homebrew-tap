class CodebuddyCodeAT21240 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.124.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "fa3ce243f4c3d2ea2a1c95a8ae23b1390935f9a388980a323c2215e3700bd73d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "795e14beb5699297a24fa8658b7ccf5b7a40353941307e581232ef7f743b50dd"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "3c65d7f841794f6826a9e18342e33b13799c98cd491bcb89347bfcd5f4353fc1"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "54784208983e382ba04bc139c6e621f8d05ecc050cb0377da8abac5315324317"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ad1461dcb94e8b7b8587909e3e1af2cae30160dbdf25ab6972e5a7684c733ca9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "53e1960627173c7d5898578be33764a0105ab265fc52c2cd0c41b4bfdd0b1c3e"
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
