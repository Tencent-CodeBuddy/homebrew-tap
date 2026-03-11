class CodebuddyCodeAT2580 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.58.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "dc01ddb119a9bdfdf2b9be360c7eba28d684c6bdd14f45f859c8e7236782243a"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "fd445e1a5cf4fee34ba253337050fe6297fc2123a71fd89267c7d27e92ef781a"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "077d212179abb4c4728c2d19f005a8092e93480ede42ca6348be242b3da20d54"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "fc81547232430a223c10a64e2c185b6fe1327ca705498bc240b52f3d6a1b6ed9"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "dfef59141e6072b0ea98a6c909f2d9d74f4a8b6ca0c9b666d3f9fc2cf9e77af6"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "2cd09393648cb6df104c5647556a9b6fd9e1f25cd9e174bf9bd468adba1e32ad"
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
