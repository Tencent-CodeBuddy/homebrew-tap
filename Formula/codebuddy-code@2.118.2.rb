class CodebuddyCodeAT21182 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.118.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "929b39ae5aa660dcb4f6d2bc608c5051f75fc19336b8325904c3d8aca353fe9e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "cf4b1f8bf68fe43913e245c61c8e55eea7ce873af4368996289d3913ef23d511"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d52d0896156e0717fa254590466c8003408cc5c72c68bc013528ee0d5dc8c226"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "ea7f8b5a9f29f62ea0ef5b286ab3537c3251cf04b178d7d2a555bfa4d2692d7b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "1959db687eeb33d01f687bc1dd39b4755304dc9dd12eb5e79210611687f6954f"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "c3fcf515fc419eca80e1401167465f186bd5bcddf1945ae48131bf5686de6201"
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
