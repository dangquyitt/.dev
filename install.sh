#!/usr/bin/env bash
# Symlink the configs listed in CONFIGS from this repo's .config/ into ~/.config/.
# Existing configs are moved to <name>.bak.<timestamp> before linking.
set -euo pipefail

CONFIGS=(ghostty mise nvim)

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

mkdir -p "$CONFIG_HOME"

for name in "${CONFIGS[@]}"; do
  src="$DOTFILES/.config/$name"
  dest="$CONFIG_HOME/$name"

  if [ ! -d "$src" ]; then
    echo "missing $src" >&2
    exit 1
  fi

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok      $dest"
    continue
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak.$TIMESTAMP"
    echo "backup  $dest -> $dest.bak.$TIMESTAMP"
  fi

  ln -s "$src" "$dest"
  echo "link    $dest -> $src"
done
