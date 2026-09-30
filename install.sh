#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$HOME/.local/bin"
install -m 0755 "$ROOT/bin/antigravity-autoupdate" "$HOME/.local/bin/antigravity-autoupdate"
echo "Installed: $HOME/.local/bin/antigravity-autoupdate"
"$HOME/.local/bin/antigravity-autoupdate" check
