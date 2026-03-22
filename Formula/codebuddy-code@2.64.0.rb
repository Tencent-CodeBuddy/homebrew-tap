class CodebuddyCodeAT2640 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.64.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "52a056f9cf130d834245ca0dcece814db9e6c035740f000ae297b8be9fff2c6f"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "010f0f22f1ac406109b87de4a996fd3b5c05a1e638d6d702e493833c945daf25"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "a5c75c778d0bc5bb470f1f1b19f62f7ecad4549f7fa31f2e9bec14667091c529"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "019a624be6fe895b1153732f09a03a4f00cb48cf2d09541f4b4980a7996b6e1d"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "7b5f220fd4b7425e451150cbadd06072196a85e0d6c43ea94aa9ec94fff713c9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "2894a0649db93d36c42a1506b742f0ef194e8fe63554b409ee294ee10a045e02"
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
