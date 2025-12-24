# 触发 Homebrew Tap 更新

这个文档说明如何从主仓库（如 codebuddy-code 仓库）触发 Homebrew Tap 的自动更新。

## 前置条件

1. **创建 GitHub Token**
   - 访问 [GitHub Developer Settings](https://github.com/settings/tokens)
   - 点击 "Generate new token" → "Generate new token (classic)"
   - 赋予 `repo` 权限（或仅 `homebrew-tap` 仓库的 write 权限）
   - 复制 token

2. **在主仓库中添加 Secret**
   - 进入主仓库 Settings → Secrets and variables → Actions
   - 点击 "New repository secret"
   - 名称：`HOMEBREW_TAP_TOKEN`
   - 值：粘贴上面复制的 token

## 使用方法

### 方式 1：在 GitHub Actions 中触发

```yaml
# 在主仓库的 .github/workflows/release.yml 中

- name: Extract version
  id: version
  run: echo "VERSION=${GITHUB_REF#refs/tags/v}" >> $GITHUB_OUTPUT

- name: Trigger Homebrew Tap Update
  run: |
    curl -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer ${{ secrets.HOMEBREW_TAP_TOKEN }}" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/Tencent-CodeBuddy/homebrew-tap/dispatches \
      -d "{
        \"event_type\": \"release-update\",
        \"client_payload\": {
          \"version\": \"${{ steps.version.outputs.VERSION }}\"
        }
      }"

- name: Wait for update
  run: echo "Homebrew tap update triggered for version ${{ steps.version.outputs.VERSION }}"
```

### 方式 2：在本地开发环境中触发

```bash
# 设置 token
export GITHUB_TOKEN="your_personal_access_token"

# 触发更新
curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/Tencent-CodeBuddy/homebrew-tap/dispatches \
  -d '{
    "event_type": "release-update",
    "client_payload": {
      "version": "2.24.0"
    }
  }'
```

### 方式 3：使用 GitHub CLI

```bash
# 需要先配置 GitHub CLI
gh workflow run update-formula.yml -R Tencent-CodeBuddy/homebrew-tap \
  -f version=2.24.0
```

## 工作流程说明

1. **版本验证**：检查版本号格式是否为 X.Y.Z
2. **运行 release.sh**：
   - 从构建服务器下载 checksums.txt
   - 解析各平台的 SHA256 哈希值
   - 更新 Formula/codebuddy-code.rb
   - 创建版本化 Formula/codebuddy-code@X.Y.Z.rb
3. **提交变更**：自动提交并推送到 main 分支
4. **创建摘要**：生成 GitHub Actions 摘要
5. **上传制品**：将更新后的 formulas 保存为制品（保留 30 天）

## 监控和调试

### 查看工作流运行状态

访问 Tap 仓库的 Actions 页面：
https://github.com/Tencent-CodeBuddy/homebrew-tap/actions

### 常见问题

**问题 1：版本格式错误**
```
Error: Invalid version format. Expected X.Y.Z, got: 2.24.0-beta
```
解决：只支持 X.Y.Z 格式，不支持预发布标签

**问题 2：无法下载 checksums**
```
Error: Failed to download checksums for version 2.24.0
```
解决：检查 release.sh 中的 BASE_URL 是否正确，确保 checksums.txt 已上传到对应版本目录

**问题 3：权限不足**
```
fatal: could not read Username for 'https://github.com'
```
解决：检查 HOMEBREW_TAP_TOKEN 是否正确配置在主仓库的 Secrets 中

## 完整工作流示例（主仓库）

```yaml
name: Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build artifacts
        run: |
          # 你的构建步骤
          echo "Building version ${GITHUB_REF#refs/tags/v}"

  release:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Extract version
        id: version
        run: echo "VERSION=${GITHUB_REF#refs/tags/v}" >> $GITHUB_OUTPUT

      - name: Create GitHub Release
        run: |
          # 创建 release 并上传 checksums
          # 确保 checksums.txt 上传到：
          # https://your-cdn/releases/download/${VERSION}/checksums.txt

      - name: Trigger Homebrew Tap Update
        run: |
          curl -X POST \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: Bearer ${{ secrets.HOMEBREW_TAP_TOKEN }}" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            https://api.github.com/repos/Tencent-CodeBuddy/homebrew-tap/dispatches \
            -d "{
              \"event_type\": \"release-update\",
              \"client_payload\": {
                \"version\": \"${{ steps.version.outputs.VERSION }}\"
              }
            }"

      - name: Announce update
        run: |
          echo "Version ${{ steps.version.outputs.VERSION }} released!"
          echo "Homebrew update triggered"
```

## 验证安装

触发更新后，可以验证 Homebrew 是否能正常安装最新版本：

```bash
# 添加或更新 tap
brew tap Tencent-CodeBuddy/tap

# 安装或升级
brew install codebuddy-code
# 或
brew upgrade codebuddy-code

# 验证版本
codebuddy --version
```
