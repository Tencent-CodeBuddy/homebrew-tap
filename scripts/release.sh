#!/usr/bin/env bash
# Create a versioned formula for codebuddy-code
#
# The main formula (codebuddy-code.rb) dynamically fetches the latest version,
# so it doesn't need updates. This script only creates versioned formulas
# (codebuddy-code@x.y.z.rb) for users who want to install specific versions.
#
# Usage: ./scripts/release.sh <version>
# Example: ./scripts/release.sh 2.24.0

set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 2.24.0"
    exit 1
fi

VERSION="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FORMULA_DIR="$REPO_ROOT/Formula"
BASE_URL="https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases"

echo "Creating versioned formula for CodeBuddy Code v${VERSION}"
echo ""

# Step 1: Download and validate checksums
echo "→ Downloading checksums..."
CHECKSUMS=$(curl -fsSL "$BASE_URL/download/$VERSION/checksums.txt" 2>/dev/null)

if [ -z "$CHECKSUMS" ]; then
    echo "Error: Failed to download checksums for version $VERSION"
    echo "URL: $BASE_URL/download/$VERSION/checksums.txt"
    exit 1
fi

# Step 2: Extract SHA256 for each platform
SHA256_DARWIN_ARM64=$(echo "$CHECKSUMS" | grep "codebuddy-code_Darwin_arm64.tar.gz" | awk '{print $1}')
SHA256_DARWIN_X64=$(echo "$CHECKSUMS" | grep "codebuddy-code_Darwin_x86_64.tar.gz" | awk '{print $1}')
SHA256_LINUX_ARM64=$(echo "$CHECKSUMS" | grep "codebuddy-code_Linux_arm64.tar.gz" | grep -v musl | awk '{print $1}')
SHA256_LINUX_ARM64_MUSL=$(echo "$CHECKSUMS" | grep "codebuddy-code_Linux_arm64_musl.tar.gz" | awk '{print $1}')
SHA256_LINUX_X64=$(echo "$CHECKSUMS" | grep "codebuddy-code_Linux_x86_64.tar.gz" | grep -v musl | awk '{print $1}')
SHA256_LINUX_X64_MUSL=$(echo "$CHECKSUMS" | grep "codebuddy-code_Linux_x86_64_musl.tar.gz" | awk '{print $1}')

if [ -z "$SHA256_DARWIN_ARM64" ] || [ -z "$SHA256_DARWIN_X64" ] || \
   [ -z "$SHA256_LINUX_ARM64" ] || [ -z "$SHA256_LINUX_ARM64_MUSL" ] || \
   [ -z "$SHA256_LINUX_X64" ] || [ -z "$SHA256_LINUX_X64_MUSL" ]; then
    echo "Error: Failed to extract all checksums"
    exit 1
fi

echo "✓ Checksums verified"
echo ""

# Step 3: Generate versioned formula
VERSION_SUFFIX=$(echo "$VERSION" | tr -cd '[:alnum:]')
VERSIONED_FORMULA="$FORMULA_DIR/codebuddy-code@${VERSION}.rb"
CLASS_NAME="CodebuddyCodeAT${VERSION_SUFFIX}"

echo "→ Creating Formula/codebuddy-code@${VERSION}.rb..."

cat > "$VERSIONED_FORMULA" << 'FORMULA_EOF'
class CLASS_NAME_PLACEHOLDER < Formula
  desc "AI-powered coding assistant for terminal, IDE, and GitHub"
  homepage "https://cnb.cool/codebuddy/codebuddy-code"
  license "MIT"
  version "VERSION_PLACEHOLDER"

  base_url = "https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/#{version}"

  if OS.mac?
    if Hardware::CPU.arm?
      url "#{base_url}/codebuddy-code_Darwin_arm64.tar.gz"
      sha256 "SHA256_DARWIN_ARM64_PLACEHOLDER"
    else
      url "#{base_url}/codebuddy-code_Darwin_x86_64.tar.gz"
      sha256 "SHA256_DARWIN_X64_PLACEHOLDER"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      if File.exist?("/lib/libc.musl-aarch64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_arm64_musl.tar.gz"
        sha256 "SHA256_LINUX_ARM64_MUSL_PLACEHOLDER"
      else
        url "#{base_url}/codebuddy-code_Linux_arm64.tar.gz"
        sha256 "SHA256_LINUX_ARM64_PLACEHOLDER"
      end
    else
      if File.exist?("/lib/libc.musl-x86_64.so.1") || `ldd /bin/ls 2>&1`.include?("musl")
        url "#{base_url}/codebuddy-code_Linux_x86_64_musl.tar.gz"
        sha256 "SHA256_LINUX_X64_MUSL_PLACEHOLDER"
      else
        url "#{base_url}/codebuddy-code_Linux_x86_64.tar.gz"
        sha256 "SHA256_LINUX_X64_PLACEHOLDER"
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
FORMULA_EOF

# Replace placeholders with actual values
sed -i.bak "s/CLASS_NAME_PLACEHOLDER/${CLASS_NAME}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/VERSION_PLACEHOLDER/${VERSION}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/SHA256_DARWIN_ARM64_PLACEHOLDER/${SHA256_DARWIN_ARM64}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/SHA256_DARWIN_X64_PLACEHOLDER/${SHA256_DARWIN_X64}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/SHA256_LINUX_ARM64_MUSL_PLACEHOLDER/${SHA256_LINUX_ARM64_MUSL}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/SHA256_LINUX_ARM64_PLACEHOLDER/${SHA256_LINUX_ARM64}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/SHA256_LINUX_X64_MUSL_PLACEHOLDER/${SHA256_LINUX_X64_MUSL}/g" "$VERSIONED_FORMULA"
sed -i.bak "s/SHA256_LINUX_X64_PLACEHOLDER/${SHA256_LINUX_X64}/g" "$VERSIONED_FORMULA"
rm -f "${VERSIONED_FORMULA}.bak"

echo "✓ Created Formula/codebuddy-code@${VERSION}.rb"
echo ""

# Step 4: Update base formula if applicable
BASE_FORMULA="$FORMULA_DIR/codebuddy-code.rb"

# Extract pure version number (filter out -next-xx, -beta.x, etc.)
PURE_VERSION=$(echo "$VERSION" | grep -oE '^[0-9]+\.[0-9]+\.[0-9]+')

# Check if it's a pre-release version
if [ "$VERSION" != "$PURE_VERSION" ]; then
    echo "⚠ Pre-release version detected, skipping base formula update"
else
    # Get current version from base formula
    CURRENT_VERSION=$(grep 'version "' "$BASE_FORMULA" | head -1 | sed 's/.*version "\([^"]*\)".*/\1/')
    
    # Compare versions using sort -V
    HIGHER_VERSION=$(printf '%s\n%s' "$CURRENT_VERSION" "$VERSION" | sort -V | tail -1)
    
    if [ "$VERSION" = "$HIGHER_VERSION" ] && [ "$VERSION" != "$CURRENT_VERSION" ]; then
        # Copy versioned formula to base formula, replacing class name
        sed 's/class CodebuddyCodeAT[^ ]*/class CodebuddyCode/' "$VERSIONED_FORMULA" > "$BASE_FORMULA"
        echo "✓ Updated base formula codebuddy-code.rb to version $VERSION"
    else
        echo "⚠ Version $VERSION is not higher than current version $CURRENT_VERSION, skipping base formula update"
    fi
fi

echo ""
echo "Next steps:"
echo "  1. Review: cat Formula/codebuddy-code@${VERSION}.rb"
echo "  2. Test: brew install ./Formula/codebuddy-code@${VERSION}.rb"
echo "  3. Commit: git add Formula/ && git commit -m \"Add version ${VERSION}\""
