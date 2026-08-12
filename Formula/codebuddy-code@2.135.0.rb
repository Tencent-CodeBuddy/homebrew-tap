class CodebuddyCodeAT21350 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.135.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "2060ec72a56a91ad15249a22b58943c854096f972971b5973d8b893d961fa4c0"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "ef4bee1c566bee4e304f32e92972558fea9d3a834db85e8dfca61c905438be12"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "e2b58e2fa14d621f88de3904964617e25dbacd65a409eb1a8ce0e728318992a6"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "0ede16a2e865f611dd39a705e5354863b88138c7fec475062ffd17d535461c06"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "5ede45c6edb7075782cfa69c4566225ff4d5ec4499ea5aef499db13cbee9f3f2"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "972fdf80dedd5d7f071efd952de9ba74a827dd82f52e34163d549e180c34c189"
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
