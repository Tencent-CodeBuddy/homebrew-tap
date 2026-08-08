class CodebuddyCodeAT21331 < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "2.133.1"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "b8821b88873372f9a2b628f7df4b4a76561c63efc63a93459fdb87ea16d9f768"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "cb40007b7f4d8e49253251b15ee55fbc09078fae2448451e1d0be6e0712cc47f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "90271f634bf51c4ac8e1859a159395fe463fce2d767152eccf3f5ccbffc793fe"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "5e260eec6c7b50ebbc09cf63073e13897e9beb5776f3277ab9b47ac5ecfcf461"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "ac78025f2c79bb7b3a7460057053606bfa2334e88ca6a2cf63ae9a18f65da12e"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "0129aee685ae4fda97748b022827f149d313e99e920504ff32072ea372f9825a"
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
