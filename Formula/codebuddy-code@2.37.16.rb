class CodebuddyCodeAT23716 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.37.16"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "3feb2ce39ba5005622a235361b7d2c039fd327410160c191a534ae3b85e612fa"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "adf379827f81b4faa033a3911cd0e96b98a34ff225b43bc7424094ab1c6035c8"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "84af0d3503941fcb1148e7ea18eba4629a4d85a061b6ac98e590f31d1e167fa8"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "29a6cdb52835e822835ca2805b33bb1dd5a18b19a3452055e72572417bc37597"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "53947472455af8abd905d4a2da639b39b84a5129bf32f5f39ac452a79393ae51"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "26e6761adc4720071f3a98f976ac8a068e7ebc905e912759293d78636fad7787"
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
