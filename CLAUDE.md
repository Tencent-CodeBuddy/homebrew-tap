# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Official Homebrew tap for `codebuddy-code` — an AI-powered coding assistant CLI. This repo contains only Homebrew formulae plus the release automation that generates them. There is no application source code here; binaries are built upstream and published to a Tencent COS bucket, and this repo just points at them.

Tap name (user-facing): `Tencent-CodeBuddy/tap`. Install via `brew install Tencent-CodeBuddy/tap/codebuddy-code`.

## Layout

- `Formula/codebuddy-code.rb` — the "latest" formula. Pinned to a specific version; gets overwritten in place when a newer pure-semver release lands.
- `Formula/codebuddy-code@X.Y.Z.rb` — one immutable file per published release (171+ files). Class name is `CodebuddyCodeAT<digits>` (the version with all non-alphanumerics stripped, e.g. `CodebuddyCodeAT2975`).
- `scripts/release.sh` — generates a versioned formula and conditionally updates the base formula.
- `.github/workflows/update-formula.yml` — wraps `release.sh` for `repository_dispatch` (event type `release-update`) and `workflow_dispatch` invocations.
- `docs/TRIGGER_WORKFLOW.md` — how the upstream repo triggers this tap (in Chinese; covers the `HOMEBREW_TAP_TOKEN` secret and the dispatch payload shape).

## How a release flows

1. Upstream publishes binaries + `checksums.txt` under `https://acc-1258344699.cos.ap-guangzhou.myqcloud.com/@tencent-ai/codebuddy-code/releases/download/<VERSION>/`.
2. Upstream `POST`s to `repos/Tencent-CodeBuddy/homebrew-tap/dispatches` with `event_type: release-update` and `client_payload.version`. The workflow also accepts manual `workflow_dispatch` with `version` (or `"latest"`, which resolves via the `releases/latest` endpoint).
3. The workflow validates the version against `^[0-9]+\.[0-9]+\.[0-9]+$` (strict — `2.24.0-beta` is rejected at the workflow layer), skips if `Formula/codebuddy-code@<VERSION>.rb` already exists, otherwise runs `scripts/release.sh <VERSION>`.
4. `release.sh` downloads `checksums.txt`, extracts six SHA256s (Darwin arm64/x86_64, Linux arm64/arm64_musl/x86_64/x86_64_musl), writes the versioned formula by `sed`-substituting placeholders in an embedded heredoc, then — only if the version is pure semver AND higher than the current `version "..."` in `codebuddy-code.rb` (compared via `sort -V`) — copies the new file over `codebuddy-code.rb`, rewriting the class name from `CodebuddyCodeAT<digits>` back to `CodebuddyCode`.
5. The workflow commits as `github-actions[bot]` with message `Bump codebuddy-code version to <VERSION>` and pushes to `main`.

## Formula shape conventions

All formulae follow the exact same template (see `scripts/release.sh` for the source of truth). When editing, keep these intact:

- Six download variants gated by `OS.mac?` / `OS.linux?` × `Hardware::CPU.arm?` × musl detection (`File.exist?("/lib/libc.musl-*.so.1")` with an `ldd /bin/ls` fallback).
- `base_url` is computed from `version` so URLs and version stay in sync.
- `install` does `bin.install "codebuddy"` then `bin.install_symlink "codebuddy" => "cbc"` — the `cbc` symlink is part of the contract; the `test do` block asserts both exist.
- The test runs `codebuddy --version` and asserts the version string appears in output.

## Common commands

```bash
# Create a versioned formula locally (also updates base formula if newer pure-semver)
./scripts/release.sh 2.97.5

# Audit a formula with Homebrew (requires brew installed)
brew audit --strict --new Formula/codebuddy-code.rb
brew style Formula/codebuddy-code.rb

# Test install from a local formula file
brew install --build-from-source ./Formula/codebuddy-code.rb
brew test codebuddy-code

# Trigger the update workflow remotely (requires repo write token)
gh workflow run update-formula.yml -R Tencent-CodeBuddy/homebrew-tap -f version=2.97.5
```

## Gotchas

- **Pre-release versions** (anything not matching `X.Y.Z`): the workflow rejects them outright. `release.sh` run locally tolerates them — it generates the versioned formula but skips updating the base formula. Only invoke `release.sh` directly when you intentionally want this path.
- **The base formula is not auto-bumped on downgrade.** `release.sh` uses `sort -V` and only overwrites `codebuddy-code.rb` when the incoming version is strictly higher. If you need to roll back, edit `codebuddy-code.rb` by hand (or copy the appropriate versioned formula over it, rewriting the class name).
- **Class naming**: the versioned class is `CodebuddyCodeAT` + version with non-alphanumerics stripped (`tr -cd '[:alnum:]'`), so `2.97.5` → `CodebuddyCodeAT2975`. Homebrew derives this from the filename, so don't rename files without updating the class.
- **Never hand-edit the SHA256s** — they must match the upstream `checksums.txt`. Re-run `release.sh` to regenerate.
- **Don't delete old versioned formulae** unless explicitly asked; users may pin to specific versions via `brew install codebuddy-code@X.Y.Z`.
