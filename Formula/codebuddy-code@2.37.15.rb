class CodebuddyCodeAT23715 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.15"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "e1d968349b6f1b8f33320acfee3d807303503f2d549867a5928368381fe88b9a"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "8e05b1b9b724829055450ab7819e55fd6669d946a23b8b659b6f9b69fe0ee484"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "aeb05b4998b3a2c7f18c290f7bb1e6e4448b7ee563d8ce10f31f748f840913ae"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "3ca241ae4c837658780aecf3dc0419ea9f7deda51e642f0b4006451efc9c83b6"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "7624a926d9da48b6e8c1ee752dd1864c18864ae19804f31edc005a76d46436aa"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "2b3bc2bebc77d5782fd5f58aba87d9701990ff69bb0313d580420c96cd012040"
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
