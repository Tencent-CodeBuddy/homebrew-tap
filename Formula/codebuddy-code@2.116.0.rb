class CodebuddyCodeAT21160 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.116.0"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "2f2e51c25ead21243cb494586c60820ae1402f51acdb39c6f5ceccf2d8c605b7"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "a2370e7ead9a258edd9ec7830566f58b5a2c5ebaeee5d1463106d86f97ee1bc2"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "d07636779fbb358315b7ec51aab7c154935f1c595276837cdabfddbe6269f95f"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "79ddc55db34cfce417979a54c18ad611b47e0eabb02eae28384c9e0b6748b7fc"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "7825fa45f7b506843a6d8cfee7bf51aa89c5a5ced4ba631ad2001be493d71ef8"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "e0888ff162de8aa2c26363449b82aebdb704fa1882e6a28df0a8101b2378601e"
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
