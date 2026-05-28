# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup

Run `~/dotfiles/setup` once after cloning to `~`. It backs up existing files to `~/dotfiles_old/`, then symlinks everything from `dotfiles/` into `~`. It also installs vim-plug for both Vim and Neovim.

For Neovim specifically, run `nvimrc/setup` — it symlinks `nvimrc/` to `~/.config/nvim`.

For crontab-based cloud sync, add `* * * * * $HOME/dotfiles/crontab/sync_clouds.sh` via `crontab -e`.

## Repository Structure

- `dotfiles/` — files that get symlinked to `~`. These are the "live" configs.
- `nvimrc/` — Neovim config; symlinked to `~/.config/nvim` via `nvimrc/setup`.
- `crontab/` — shell script for cloud sync.

### Symlinked files

`.bashrc`, `.zshrc`, `.ssh/config`, `.vimrc`, `.tmux.conf`, `.tmux`, `.emacs.d`, `.gitconfig`, `.gitconfig-f0t0n`, `.gitconfig-competera`, `.gitignore`, `.zsh_user_functions.zsh.f0t0n`

## Emacs Config (`dotfiles/.emacs.d/`)

`init.el` is the entry point; it loads files from `customizations/` in order:

```
shell-integration.el → navigation.el → ui.el → editing.el → misc.el
→ common-lisp.el → setup-clojure.el → setup-js.el → setup-ts.el → setup-markdown.el
```

Package manager: `package.el` with melpa-stable (priority 10), melpa (priority 5), and gnu ELPA. `markdown-preview-mode` and `websocket` are pinned to melpa.

Key packages: `sly` (Common Lisp REPL, SBCL backend), `cider` + `clojure-mode` (Clojure), `vterm`, `paredit`, `magit`, `projectile`, `zenburn-theme`, `markdown-preview-mode`.

Markdown preview uses a custom zenburn theme: `dotfiles/.emacs.d/zenburn-preview.css` is read at startup, base64-encoded, and injected as a data URI into `markdown-preview-stylesheets` (bypasses the package's HTTP server which only serves files from the markdown file's directory).

SLY REPL uses `C-<return>` to evaluate (bypasses paredit's RET). Clojure custom bindings: `C-c C-v` start HTTP server, `C-M-r` refresh, `C-c u` switch to user ns.

## Neovim Config (`nvimrc/`)

Source of truth is Fennel (`.fnl` files under `nvimrc/fnl/f0t0n/`). At runtime, hotpot.nvim compiles Fennel to Lua transparently — edit `.fnl` files, not generated Lua.

Plugin manager: `lazy.nvim`. Plugins are declared in `fnl/f0t0n/lazy/init.fnl` (and per-plugin files in the same dir). Leader key: `,`.

`init.lua` bootstraps lazy.nvim, then hotpot.nvim, then loads Fennel modules via `require("f0t0n.lazy")` and `require("f0t0n")`.

## Git Config

Conditional identity includes: `~/.gitconfig-f0t0n` for `~/`, `~/.gitconfig-competera` for `~/code/competera/`. GPG signing is enabled (`commit.gpgsign = true`), using `/opt/homebrew/bin/gpg` on macOS.

## Tmux Config

Plugin load order matters: plugins are initialized via `source ~/.tmux/plugins.tmux` (must stay last in `.tmux.conf`).

Key bindings: `M-h/j/k/l` for pane navigation, `|` / `-` for splits, `r` to reload config, `D` / `U` to source `~/.tmux/dev` / `~/.tmux/user` session layouts.

## Notes

- `.zshrc` is the portable host config (oh-my-zsh, pyenv, nvm, gvm, etc.) — all hardcoded paths use `$HOME`. Symlinked to `~/.zshrc`.
- Vim config (`.vimrc`) uses vim-plug; Neovim uses lazy.nvim — they are separate setups.
