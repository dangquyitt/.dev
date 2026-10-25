#!/usr/bin/env bash
# Symlink the configs listed in CONFIGS from this repo's .config/ into ~/.config/,
# and the files listed in HOME_LINKS into $HOME.
# Existing configs are moved to <name>.bak.<timestamp> before linking.
set -euo pipefail

CONFIGS=(ghostty mise nvim tmux)

# "<path in repo>:<path under $HOME>"
HOME_LINKS=(
  ".config/zsh/zshrc:.zshrc"
  ".config/starship/starship.toml:.config/starship.toml"
)

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
TIMESTAMP="$(date +%Y%m%d%H%M%S)"

link() {
  local src="$1" dest="$2"

  if [ ! -e "$src" ]; then
    echo "missing $src" >&2
    exit 1
  fi

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok      $dest"
    return
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak.$TIMESTAMP"
    echo "backup  $dest -> $dest.bak.$TIMESTAMP"
  fi

  ln -s "$src" "$dest"
  echo "link    $dest -> $src"
}

mkdir -p "$CONFIG_HOME"

for name in "${CONFIGS[@]}"; do
  link "$DOTFILES/.config/$name" "$CONFIG_HOME/$name"
done

for pair in "${HOME_LINKS[@]}"; do
  link "$DOTFILES/${pair%%:*}" "$HOME/${pair#*:}"
done
