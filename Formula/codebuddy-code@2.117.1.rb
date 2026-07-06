class CodebuddyCodeAT21171 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.117.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f582313582cde7c5cf2e01e077cbfb54e6336c3fe9c13cd36f70162ea8285100"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b6dcee42542ed47e4f65e6dc41a116425d84ef34162e7b00b149e97fe47a6f33"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d21ee839a10a149acb4c0b05807e07dfeadad1d465e532651ef1b57e7e4d2a77"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "06e5edf924035f7f6806f6eff021a061f960ad87aed1373d55b945a1cffad93c"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "8f412b1404b9ccef339afcddc3d8a4153d5459f1510e84098b3768158b3044ef"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "ba038811b156ec2a29fe714f1b14dca87ada347d1c98841cc1946ac4824e3fa7"
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
