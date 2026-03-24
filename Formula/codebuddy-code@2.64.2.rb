class CodebuddyCodeAT2642 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.64.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ea69852fd2a42d112248e0361635ea2d3349a23dd80c71edbf65c67059557101"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d9ff042fc3c0380ef5098c2ecf64a72a007929234f829ce48c0baa315368d07b"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "f6bbea804cbf49a799fdea6be90bf3f9f2c39c8c46358f4a99f7639b784ee48f"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "437e029cbbd45416998eca1a51c96021cd43187a8cb00e113633fd50cb6da5f8"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "94a85b875fc6cac1adce6ea9c4f8e85b8d74069f249e38e90309c6b01db88337"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "c0ea30f2e43961c26e287afc4c0bcfad1a5810311163540c83eb8386f4e1cf42"
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
