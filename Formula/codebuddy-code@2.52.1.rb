class CodebuddyCodeAT2521 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.52.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "1ebaf1429883151780bdcbef484307599f8bdf1d2b07e1f6f837f7cad2868edb"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "d9a3503021dd9b1657d2520e7cad9c71927a4c1b236ce5d99ab2ea989ab90164"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "46d0f106c995cefa7d68e70491dbea6a642c1e189065e42f9a17376d2abcc855"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "66fc77ad8896c51c2ca1834f5b21640313233de18679d29b5add01293a7b741e"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "58960a78eb58bdea540f669a670e9671fd3499ac283611f2e8b8ce6b04b9b3ab"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "0120558e73acfa98cbf81d800940e858e7f15d1f038008b35802d776a9b8b36f"
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
