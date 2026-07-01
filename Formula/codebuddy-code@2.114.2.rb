class CodebuddyCodeAT21142 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.114.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "f36a462fe3b795255493cc2c1c65587cb68eaa76ffce596d85fce1345e5b2c76"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b9ad7ec592b481d81f255c0bea0814081dd79089ebe35bcfca7a7e7397571389"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "4ef4d025c09e03c6026ee765067cc6050c71a49a78bb95fad2f62865a81dbd58"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "bee2706d225207d3343e188570c0fff92c72cb41130d7609c6ff8983ab21e4a2"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "2a3f92be02548e744ea83bea0ef9708b8c00414877107449a1d6ecffe792b622"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "3e80d7a28aa6baa637d82d8cc19f68b2c4e351b7263e72f9edd006684eebbc8e"
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
