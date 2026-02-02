class CodebuddyCodeAT2440 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.44.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "5eeb7b7b239107023452c9f2acd152a44cba28a0f265dd86cd6e49134f6c0fc8"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "1a8800afd8ae1d98b18444f06a47ccada91776367c46b13876082aaac2061a99"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "2b6f799b071ca28b8aeb4015d305d6c01c426453be86d76a9fb1509a7315c70a"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "a49d7f3ded94f1b127b854cad92e9acbe3353652b1d5c04e6f7521d1c8e69021"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "76ddd7def1650fb2a86149ee85b89d02b148188b7f38c822f33c8087a8e0bc87"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e0881b4f9b4373e34fa4fa71fdcdb9f3e4b06953c4b71024250975895f52e31c"
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
