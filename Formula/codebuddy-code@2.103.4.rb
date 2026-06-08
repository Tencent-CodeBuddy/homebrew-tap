class CodebuddyCodeAT21034 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.103.4"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "1782cb758c4ee7a1068065319773573c3f25d3269307ecc6eb7a052891baf766"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "02863e0ca6108e453152a4630a225224cf9768c5c5c158619d7777f2c563d89e"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "42a3368b6eb45c87bc8a4ec58c6523cee64b63c29bd2dbe144da92d2c2971f10"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "075a3c8438d96d60aac7fa661f5a650234f469808a48424a199cfeb31ed4bcfc"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "86d6047eb811b40bd92a07cf72d0105f3173be564d2581ef9ec35bf50488bdd0"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1596d48f2fb3f84865681408189d365aaa5d8a65b3c9bea7ce080f784d1f2082"
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
