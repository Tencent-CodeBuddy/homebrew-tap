class CodebuddyCodeAT21510 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.151.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "8fac40ce671d8c9bcce24a6bc5cdd6696280447fca42ce9c52a068bfd9a56a3f"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "95f2c3c6c94e52438c66c503475699e583cc3ceaf28a9140c8e0504641dd0f8d"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "cc8947f2930aa3152946e4aa8cbd2573ee57141094bd058ca0b56bb5dc485384"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "3dece497564391f19b73d41fd484501b5467299de0138ccc07f400c0ca9d5bce"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "cc65f92dbb3e52f9ac460dd4dc78000b0fb1a19ba53e3fc14c037d1365fc8e5d"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "ae39fdecddec958fd2f7f1d0a1d3ae60d8dcb4f4038c97435ac25a6800781396"
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
