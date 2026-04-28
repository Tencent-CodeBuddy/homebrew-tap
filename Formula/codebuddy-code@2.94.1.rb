class CodebuddyCodeAT2941 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.94.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "cba49c5580ad6b4de01d88fb46ba2782d739a7417d56472bd0dedabe3496ddcf"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "cb4c55495ef7ce497b6454ecd725d1deac875ada7e4000a5070faca58f6843a0"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "a8234174ba4edb7f9c0130c2c1894ce6f2958eb2141394e36f27ba84c500d6db"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "517b9b65e611862afbb5d4fbe99cdaff52e1ec0f9ad1f1e461c1e8f06b606131"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "be74410b9aa48db75b6215435aa9532bfda165f82bc8c62356b5c6da000f23b9"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "299630f3cff894dcd940bf06693eb8278131adde01de5c1d7a9ad92eb55a26df"
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
