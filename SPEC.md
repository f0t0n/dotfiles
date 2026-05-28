# Spec: f0t0n Dotfiles

## Objective

Portable, reproducible developer environment for a single engineer (f0t0n) working across personal and Competera work contexts on macOS. The repo holds all shell, editor, multiplexer, and git configs as the canonical source of truth, deployed to `~` via symlinks.

**Success looks like:** cloning to `~/dotfiles` and running `~/dotfiles/setup` produces a fully functional environment with correct editor configs, git identities, shell tooling, and cloud sync — with no manual file copying.

## Tech Stack

| Tool | Role |
|---|---|
| Bash/sh | setup scripts |
| Zsh + oh-my-zsh | interactive shell |
| Neovim + lazy.nvim + hotpot.nvim | primary editor (Fennel config) |
| Emacs + package.el | Clojure / Common Lisp IDE |
| Vim + vim-plug | fallback/quick editor |
| tmux | terminal multiplexer |
| GPG (/opt/homebrew/bin/gpg) | commit signing |
| pyenv / nvm / gvm | language version managers |
| pandoc | markdown rendering backend |
| markdown-preview-mode | live browser preview for markdown |

## Commands

```
# Initial setup (run once after cloning to ~)
~/dotfiles/setup

# Neovim config setup (run once, from repo root)
cd ~/dotfiles/nvimrc && ./setup

# Vim plugin install (inside vim)
:PlugInstall

```

## Project Structure

```
dotfiles/                   ← repo root
├── setup                   ← main install script (symlinks dotfiles/, installs vim-plug)
├── CLAUDE.md               ← AI assistant guidance
├── SPEC.md                 ← this file
├── README.md               ← human-facing overview
├── dotfiles/               ← files symlinked to ~
│   ├── .zshrc              ← oh-my-zsh shell (pyenv, nvm, gvm, kubectl, AWS ECR)
│   ├── .zsh_user_functions.zsh.f0t0n  ← custom zsh functions
│   ├── .bashrc             ← bash fallback config
│   ├── .vimrc              ← Vim config (vim-plug)
│   ├── .gitconfig          ← git: conditional identity includes, GPG signing
│   ├── .gitconfig-f0t0n    ← personal git identity
│   ├── .gitconfig-competera ← work git identity
│   ├── .gitignore          ← global gitignore
│   ├── .tmux.conf          ← tmux: vim-nav, status bar, plugin load
│   ├── .tmux/              ← tmux extras (plugins, session layouts)
│   │   ├── plugins.tmux    ← TPM plugin declarations (sourced last by .tmux.conf)
│   │   ├── dev             ← dev session layout
│   │   └── user            ← user session layout
│   ├── .emacs.d/           ← Emacs config
│   │   ├── init.el         ← entry point: packages + loads customizations/
│   │   ├── zenburn-preview.css ← zenburn theme for markdown-preview-mode browser output
│   │   └── customizations/ ← shell-integration, navigation, ui, editing, misc,
│   │                           common-lisp, setup-clojure, setup-js, setup-ts,
│   │                           setup-markdown
│   └── .ssh/config         ← SSH host aliases
├── nvimrc/                 ← Neovim config (symlinked to ~/.config/nvim)
│   ├── setup               ← symlinks nvimrc/ → ~/.config/nvim
│   ├── init.lua            ← bootstraps lazy.nvim → hotpot.nvim → Fennel modules
│   ├── lazy-lock.json      ← locked plugin versions
│   └── fnl/f0t0n/          ← Fennel source (hotpot compiles at runtime)
│       ├── init.fnl         ← top-level config
│       ├── remap.fnl        ← keybindings (leader = ,)
│       ├── set.fnl          ← vim options
│       └── lazy/            ← per-plugin Fennel specs
│           ├── init.fnl     ← plugin list
│           ├── lsp.fnl, treesitter.fnl, telescope.fnl, ...
```

## Code Style

**Shell scripts:** POSIX sh where possible (`#!/usr/bin/env sh`), bash for setup scripts. No dependencies beyond standard Unix tools + the tools being configured.

**Fennel (Neovim):** Edit `.fnl` source files only — never generated Lua. hotpot compiles transparently at runtime. Per-plugin files in `nvimrc/fnl/f0t0n/lazy/`.

**Emacs Lisp:** One file per concern in `customizations/`. `init.el` loads them sequentially. Custom-set-variables isolated to `custom.el`.

**Markdown preview theme:** `zenburn-preview.css` in `.emacs.d/` is the source of truth. `setup-markdown.el` reads it at startup, base64-encodes it, and sets `markdown-preview-stylesheets` to a data URI — avoids the package HTTP server's restriction of only serving files from the markdown file's directory. Edit `zenburn-preview.css` directly; changes take effect on next Emacs restart.

**Git config:** Conditional identity via `[includeIf "gitdir:..."]`. GPG signing always on. Work configs (`~/code/competera/`) override personal defaults.

## Testing Strategy

No automated test suite — configs are tested by use. Manual verification:

- After `setup`: confirm symlinks exist (`ls -la ~/ | grep dotfiles`)
- After Neovim changes: `:checkhealth` + `:Lazy` status
- After Emacs changes: start Emacs, check for errors in `*Messages*`
- After tmux changes: `tmux source ~/.tmux.conf` and verify no errors
- After `.zshrc` changes: `source ~/.zshrc` and confirm env vars load

## Boundaries

**Always:**
- Keep all hardcoded paths relative to `$HOME` (not `/Users/f0t0n`) for portability
- Source `.tmux/plugins.tmux` last in `.tmux.conf` (TPM requirement)
- Edit Fennel files (`.fnl`), not generated Lua
- Run `git config --global core.excludesfile ~/.gitignore` after adding global ignores
- Keep `setup` idempotent: running it twice must not corrupt state

**Ask first:**
- Adding new files to the symlink list in `setup`
- Changing git identity config (`gitconfig-f0t0n`, `gitconfig-competera`)
- Modifying SSH config
- Adding new Emacs packages to `my-packages`
**Never:**
- Commit secrets, API keys, or private SSH keys
- Hardcode `/Users/f0t0n` — use `$HOME` or `~` for portability
- Edit `dotfiles/.emacs.d/elpa/`, `eln-cache/`, or other generated Emacs directories
- Skip GPG signing on commits
- Modify `nvimrc/lua/` generated files directly (hotpot output)

## Success Criteria

1. `~/dotfiles/setup` runs without errors on a clean macOS install
2. `~/dotfiles/nvimrc/setup` symlinks nvimrc to `~/.config/nvim`
3. Correct git identity used per directory (`~/` → f0t0n, `~/code/competera/` → Competera)
4. `~/.zshrc` sources cleanly; pyenv, nvm, gvm, kubectl all available
5. tmux loads with vim-nav bindings and battery status in status bar
6. Neovim loads plugins via lazy.nvim; Fennel configs compile via hotpot
7. Emacs starts with Clojure/Common Lisp support (CIDER + SLY)

## Open Questions

None — retroactive spec based on current working state.
