class CodebuddyCodeAT21460 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.146.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "706ddbfad6ae7fedb627850a9a1f8e906ffec910ef4b6785dccbafdcfa6c7fc5"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "8deefcbc9253f2e282dd1c97f932d1217959d8ac4c8ebadfbaeb77c9979c7822"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "404af2c2875b8f739e0f34236eea5de27a9c4d4444091a731e66977279b5e537"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "22c799f793f79754bd84036db2cbf1ea2e7267f7e5d9dcae87feff73efd257ad"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c2e2b5ceab5484e3c9855d72fcf648678bec4bedbd1ab79ecb92d6cc029f20f1"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "ed0b94d70690d812793b590d21d73ff35b05da800bea52d4af17fa647909f5d0"
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
