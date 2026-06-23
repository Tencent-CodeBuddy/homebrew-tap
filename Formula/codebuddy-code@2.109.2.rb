class CodebuddyCodeAT21092 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.109.2"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "90f5eeac4162db5dde9333b057050bb462991844bc37cf703a97f297701cb158"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "9591fe286ec84068f71b3dd68ccbc2580f8593c1e198523e042d3b384df52b69"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "af9005a7493cffddf76c56a0713e0bb24f9f59d7f15352ee333ab12bb3f44b13"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "7184b7b33c1c9481a28ed3dd158ca61fe8d4286c732cb94d30d24138e091831b"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "1ba2da24f2dff87713cf52b9b332c024472ec186b5abc0cd6631833c049b98f8"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "d7fa93047e5f2116d3b56e1ac3230761251f23d1416d5013dbe88abbd2f20e5a"
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
