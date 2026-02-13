class CodebuddyCodeAT2502 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.50.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c9fe6f03c69d8ebc97e506ca5eeced9de39f1489f5905e81f1f96ca78cc11e1d"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "96a9fb36adc39f8da931d29d796ef793d0cfd89cd791712c5e05b5346a7dff62"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "6dc480e9c33f07640209fbb224ef940259701e950343ed06bd6c42a388a77705"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "d64aeade39027f9c71f01bf3eeb0dcb03aa3b900e691cf8ac182b4b916410965"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "45e43fe73b84e329609da58bb937f08e63052eb2294633f5696624d829f88ef4"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "b51a3c39247d9d7b8511f5cc3cc659cec30a098c034f0f39d2728f7c62eab2ed"
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
