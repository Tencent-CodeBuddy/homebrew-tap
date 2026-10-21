class CodebuddyCode < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.172.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "d53ac6a58fb411bef3bb7a57e3b0240fd25d0125d98194a1258ee725bb6da496"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "77c7d8d3266f57a98aa0f17daba8472b8c2b5930b7d3ffb882565d4744c63d57"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "34d55ad21df0c241cd17079b30804a571a53a6bdc14d36404e6806d6f018ab8b"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "7ae30edbe5ec217dec9b02bafc8460a87e0b34ad7fe174fd47c7d9518461d28e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c72047e2163111940a8e18b42bff66f1212765f59c590e13df3db4e72137f58d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "71e73ff85d268859f6f6d80d12f42b115d4e0f0b9a1de999bd7916399299fada"
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
