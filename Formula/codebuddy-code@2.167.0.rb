class CodebuddyCodeAT21670 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.167.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "ef5134a41eba820807f65c8a81db099c16535d81fbbde3d9e6ce201447f2a2c4"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "24b70c4dbfb3ca025aa3c6003cc39bbc13cf33f2f4997fde6db733b3397cea60"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "483fa7b8ba3a5e8d6c8417eeaa7567a5484019df2dbe43247484155f6e31e643"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "b3f27523b5492f8470b484f010847a60482a2772e2b2b6bd3a35770f709bd8fa"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b95e34e057831f29551ec8980a4aabf5618447171f87ffcf3a2299113d199d49"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "0b3d5c5360878759c4e5bafc33c0db3a3feb0b4df70507726c1ea69dc72a34c0"
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
