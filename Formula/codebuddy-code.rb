class CodebuddyCode < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.23.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "9dba17af72d59288f971253feaab20b746394b56b55ebb0e1dc9f41fce1324f2"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "a32dd70bf3d3aa1d14c3192fd51023ee3d4b8c61261313674bdf5f4e07c3c4bb"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "8df6ec0f940a2b2387027055e37ca3e398e64e92d32b2c0df2bcf49e48e1a6c7"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "8e77a32b0a409ac77702d5fa8537f02d1dbd9ffa0efa17a1f79310de3f8cb458"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "500b96ea78ea92f28baec071ad694690d2c07912748693bec05c9c5dd35d115e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "5db6c13fe4d525e6191d9d3922ffa43c5f7688c895af9d15db063bcbb1921b77"
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
