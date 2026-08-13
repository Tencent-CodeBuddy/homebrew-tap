class CodebuddyCodeAT21360 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.136.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3dfc77003b03b209b93638276d683df2170df671583bbbdea324a854ced65c23"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "32bd0e422e4c01947493257458d518593b05aa4352197c3495a6b45faf122e01"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "b0589beba4ef65342ac16f5a5ce960adb02afcec83baab777e8988b09aa35736"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "ea30455a44925e54bb0b82e85bd0061467b1d9298faeec126c1f424c66cc9280"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "c8f6f833faf5e15ee3cc57f83979ddb252a43e98d46fe38ce25b38abce96f0bb"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "8e4d19ca0f0c7de02cb8e876139204fcbf0621030d66cb7edbf91a5a6130d5cc"
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
