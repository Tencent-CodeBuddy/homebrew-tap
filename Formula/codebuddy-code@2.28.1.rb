class CodebuddyCodeAT2281 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.28.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "da4b7a335ee3aeda040c329acf064a12ecefcbdd1d2820c12eb97297e6140c3e"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "3a94a2cd00e0e87b799b0155c10a85a347626a28d7d6eea05235111c4c1b00c4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "9d858f5bf2f23665d1e885187cff8bee3353598aae2fdbf0ba062e4c27b173ba"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "81f9450abade87137e7d73386ea8d4b9c3a6f03914cbee5cd31598641d3a9275"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "bfb96c7c209eb2114c27e43fe855a5856c5a7c97ff0dd608199d284b20658c3b"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "45a603d0dc9df1b30d3336d17e1f0054ef0675f40d1609ca62ba82dda3d8bc1b"
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
