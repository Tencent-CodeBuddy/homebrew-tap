class CodebuddyCodeAT23713 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.13"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "d96752627af8360575c3465c2988f340ce0fda02d81ebf90bf593c90429b5c13"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "a5671c2d2df58050a9a9d9fcb8223d30449247585756a5cfb381b0140aa8fc66"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "da0c7665ed20d844a1724c14f338d2a3f8b93df5ef5b9a7e5f7c52e9d71f8226"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "a58907b388ccaa788657624f97f4a34d862ff33ccf8a035939832a378e539e45"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "b115f025bd2f5ed1fc597919564ff6abf35693368943d9e73b8f30208ce90128"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "1e28a137246aea050f0314d3cb78df2f8c4514b55c211d018636c5b4facbe9f6"
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
