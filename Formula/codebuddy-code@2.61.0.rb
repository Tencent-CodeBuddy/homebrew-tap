class CodebuddyCodeAT2610 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.61.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "633c65601dee2c7acb2550f0ff48aa8f4037512cfd899842c230a665faa03409"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "26e11a28447ef6160a458f52091a5d92c022425e0b5fe15b1e71c9d94f56f04f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "4b1cdac100d3111a5024942e29bd617e90ea430f15f5f4ffc9ec5967ac83e0fe"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "3c7f3f40e00a737a33e908c11d693af0122c005224d697e11de7d33833c7aa4e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c86214fc0f122ce8238a74c1f61e4cfb0ce005181478019edb4c469c30c796bb"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "4c80d90c423f8fc792e78e4bb99a847651cda766c39921b5853503560783c2d6"
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
