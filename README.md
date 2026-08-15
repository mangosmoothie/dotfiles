# dotfiles

## Prerequisites

- Install [homebrew](https://brew.sh)
- Install [nvs](https://github.com/jasongin/nvs)
- `git config --global user.name mangosmootie`
- `git config --global user.email mangosmoothie@users.noreply.github.com`

```
brew install autojump exa fd ripgrep
```

oh-my-zsh should be installed manually

```
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

chsh -s $(which zsh)
```

## Quickstart

You can run this from anywhere:

```
source ~/projects/dotfiles/sync.sh
```

Or cd into the directory first:

```
cd ~/projects/dotfiles
source sync.sh
```

The script is now resilient to being sourced from the wrong directory (it will refuse to sync if the resolved directory doesn't contain a `.zshrc`).

## Cursor (Vim + Spacemacs-style leader)

Cursor config lives in [`cursor/`](./cursor/) and is **symlinked** into:

`~/Library/Application Support/Cursor/User/`

| File | Purpose |
|---|---|
| `cursor/settings.json` | VSCodeVim leader maps, EasyMotion, surround, core Vim feel |
| `cursor/keybindings.json` | Extra VS Code keybindings (optional) |
| `cursor/extensions.txt` | Extensions to install on sync (`vscodevim.vim`) |
| `cursor/glass-editor-preferences.json` | Glass/agent-window keybindings mode (`vim`) |

`sync.sh` excludes `cursor/` from the home rsync (so it does not land in `~/cursor`), then symlinks the JSON files, installs listed extensions, and writes Glass `keybindings: vim` into Cursor’s state DB.

### Vim in Glass / agent windows

Cursor’s agent (Glass) UI has its own **Keybindings** preference: `default` | `vim` | `emacs`. If that is `default`, Glass disables VSCodeVim even when the extension is installed.

- Sync sets `cursor/glass.editorPreferences` → `keybindings: "vim"`
- `settings.json` also pins `"vim.disableExtension": false`
- After sync: **Reload Window**. In an agent editor, `...` → Keybindings should show **Vim**
- If Cursor flips it back (known bug), re-run sync or set Keybindings → Vim again from the editor `...` menu

Classic mode is not required once Glass keybindings are set to Vim.

### Muscle memory map (from `.ideavimrc`)

- `SPC SPC` — Command Palette
- `SPC ff` / `SPC pf` — Quick Open
- `SPC sp` — Find in files
- `SPC ss` — Save all
- `SPC w/` `SPC w-` — Split right / down
- `SPC wh/j/k/l` — Focus splits
- `SPC jj` — EasyMotion char jump (AceJump-like)
- `SPC jl` — EasyMotion line jump (both directions)
- `SPC jk` — EasyMotion line jump upward only
- `SPC jw` — EasyMotion word jump
- `fd` — Escape (insert mode)
- `ysiw)` / `yse(` — Surround (vim-surround; not EasyMotion)

Reload the Cursor window after sync so VSCodeVim and Glass prefs pick up.
