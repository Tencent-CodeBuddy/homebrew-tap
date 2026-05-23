class CodebuddyCodeAT2975 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.97.5"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "6cac835c311a7d22546e50808a2bdfb56ad091708ae0be37d477b08f857708c0"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b626d047a5798409f4e3cb9ef61f9bc89ae06b5200ecd1833f6c3588eca58310"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "162e7f05508816c3af1318747fe1dce5fc93b9476005c6aef8474d6cbe021e5f"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "82cfdc6afeb8e40d43aae089df47ffc8bd40329e22926d9134a9f0987e34ec07"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "17f1ea8653efbc4ea6f0a09468d91d878dcf20bd1486581dd7a26e473eb9f7e5"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "46041bbed15cc95ce40d6eaf0fec0f2555990beba2d54e3acb8247dd37f8e4db"
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
