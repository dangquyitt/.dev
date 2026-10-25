# .dev

Dotfiles for macOS and Linux: Neovim, Ghostty, mise, tmux, zsh, Starship.

## Install

```sh
git clone https://github.com/dangquyitt/.dev.git ~/.dev && ~/.dev/install.sh
```

The script symlinks `ghostty`, `mise`, `nvim` and `tmux` from the repo's `.config/` into `~/.config/`
(or `$XDG_CONFIG_HOME` if set), `zshrc` into `~/.zshrc`, and `starship.toml` into `~/.config/starship.toml`:

```
~/.config/nvim    -> ~/.dev/.config/nvim
~/.config/ghostty -> ~/.dev/.config/ghostty
~/.config/mise    -> ~/.dev/.config/mise
~/.config/tmux    -> ~/.dev/.config/tmux
~/.zshrc          -> ~/.dev/.config/zsh/zshrc
~/.config/starship.toml -> ~/.dev/.config/starship/starship.toml
```

- Existing configs are renamed to `<name>.bak.<timestamp>` before linking, never deleted.
- Safe to re-run: links that are already correct are skipped.
- The repo can be cloned anywhere; the script resolves its own location.
- To add a new tool: create `.config/<name>/` in the repo, add `<name>` to `CONFIGS` in `install.sh`, then re-run it.
  For a file that lives in `$HOME` (like `.zshrc`), add `"<path in repo>:<path under $HOME>"` to `HOME_LINKS` instead.

## Update

```sh
cd ~/.dev && git pull
```

Since `~/.config/*`, `~/.zshrc` and `~/.config/starship.toml` point straight into the repo, every config edit lives in the repo — just commit and push.

## Uninstall

```sh
rm ~/.config/nvim ~/.config/ghostty ~/.config/mise ~/.config/tmux ~/.zshrc ~/.config/starship.toml
```

Then rename the `.bak.*` backups back if you want your old configs restored.
