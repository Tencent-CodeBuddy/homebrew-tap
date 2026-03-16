class CodebuddyCodeAT2630 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.63.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3154a62c50f3076df224097890d3960b588850bfeafdbe7e99ddba0a55416364"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "b880806a2e42a6ab3a120949dc5e897b40c08a974700c1553212549fce8f4c32"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "ee25bb98c564a853065c1d1d50192dafa9316199b07e0d67edb0ffafd09a3735"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "9f625fd21456ff101c651e85d8026cf34d95a4215bad2d65ca9ca9c7e24e398d"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "bcee9738851ba9717ba15c7145ce7175e2dbb20fa0840a9bf71d75e2b3e855a2"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "ecdf3d94eb3a6e7a5fa8e0f4e40985f1d9646899cf5182993acc89d524aca75f"
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
