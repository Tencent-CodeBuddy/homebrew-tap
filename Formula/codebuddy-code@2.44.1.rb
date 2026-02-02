class CodebuddyCodeAT2441 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.44.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3f5977101c097731c3faa8ae81fe29635d931c52045f2c1e6ef7a80f5a48bcf6"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "77c77f063ecf2d395fd3b5f843980da8b35df6445f686bc41120c5eb7d501ac4"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "df5bdbcf298698f53ecdd307e4c7a29bfc0b4756875fe3a66066df986a45dfc3"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "20959ce94eab3b858628d25cc79c2c905515f82fd47b711c7842010bb64ee672"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "04c3c292afd496d5582b4ff4ad314d128cccbeff7d7d65a24d49eb351f465476"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "68ee1140349a0beadf827674e9269ba1c83b77f598f4b2749a7b6b5eda7b6bcc"
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
