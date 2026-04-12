class CodebuddyCodeAT2850 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.85.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "c6adf73d07a9fe95b3231a6a8a3dc1fd03b6f9e8b76c22cfa3c7bb7c79a0182b"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "9f3d7c125bbbe154dd78b08b99f7757fa6d13e36afde344d447d1e1ef975abd3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "41f63ab6193d162a85209aa02fc1ca79abbeb337c7c0c72bd02c44e47072b2f2"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "49bf3d29d899a31d95d33e8ab1442b66dd8493adc581570f51268682e50d217c"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "011160eac00ed5ec7217d0d433c9c06399c5681bb61146d3765d65569f078b41"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "66655d2b170a4eed42feaad77b62f3884dc354d47568415c76547483d39d5282"
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
