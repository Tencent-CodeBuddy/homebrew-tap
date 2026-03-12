class CodebuddyCodeAT2590 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.59.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "017e6a80668f469145aece76871f78b32a04b52a5e5c125002eccfcf9592f85c"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "055789cabc3e36d23e502f8ae301c2c85d8f6c0309a9090b3ff853c0c8fb22f5"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "5f5956e890f108466d5223741d473cbf4b6cb9aef5f2a7b27383e57b86e5cada"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "89c37a67d25046737c82f95d1c0d1b02b8e05656d251f5c25b350d891a55027b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "5caebb13bdbb656c02972244aa85722c67ff7e55591cb1bd74b0b828ace24e6d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "eada9a7778697ad62607dc402da9327698bbeddf63e06479fb9a74e41db0bedb"
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
