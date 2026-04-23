class CodebuddyCodeAT2935 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.93.5"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "00e8e3bda89a608f1c34a9a37ff5d7e7bf6564cfd84b7987c54c3597254f9e43"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "02bc898a58788819a0bae821d9e3e4953ed7ed4a9a63c6294e082b9ab72951be"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "81538b4e73e8abd8d8d11dda264f73256a1dfb9f1e722c172d30f7a876db61c0"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "01f59602be6b07b4718d315c5a0b6e34bf447db7dd418ca69875e95f98b1464b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "fb2976e66f6c5efff374b9606be78f8452d829219695e3006bca280fa5378c2b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "916414d2467418c922d2ee95a22dc1e10fd5f84a6c7fa74fc1f62fd845fa5e36"
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
