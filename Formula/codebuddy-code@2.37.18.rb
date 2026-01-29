class CodebuddyCodeAT23718 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.18"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "8c31337727a8fdf5dd9ee522729a5d27ebd2e1adb6090f59a138d71a433eec24"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "6b8b0b37a8820bd10087ebdb24b98f72c5975e8b1fca01652a803d5e99827e6d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "5b54bdd2fd1abddf1a8402326113b4b36c614f49675d9eaf2075332724510035"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "5cb66668ef9086bbd61fed2ed6c8a725b7dc2cce22da9bea1cef1991e8618008"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "128c65c18f4c7df20edecf02a4b8ea0deefeb3c8e92faa5de4749839885aca77"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "efdce927c271d8331a03f12ca75d41c1dcffc336fbb06b1fa6a10a7a70d3247d"
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
