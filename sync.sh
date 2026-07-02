#!/usr/bin/env zsh

# dotfiles sync script
#
# Safe to source from anywhere:
#   source ~/projects/dotfiles/sync.sh
#   cd ~/projects/dotfiles && source sync.sh

# Resolve the directory containing this script (reliable even when sourced)
local DOTFILES_DIR=${0:A:h}

echo "==> Dotfiles dir: $DOTFILES_DIR"

# Safety check: abort if this doesn't look like the dotfiles repo.
# This prevents accidentally rsync'ing the wrong directory into ~/
if [[ ! -f "$DOTFILES_DIR/.zshrc" ]]; then
    echo "ERROR: $DOTFILES_DIR does not look like the dotfiles directory (no .zshrc found)."
    echo "Aborting to avoid syncing the wrong tree into your home directory."
    return 1 2>/dev/null || exit 1
fi

# --- Update oh-my-zsh and selected plugins ---
{
    local zsh_custom=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

    if [[ -d $HOME/.oh-my-zsh ]]; then
        echo "==> Updating oh-my-zsh..."
        git -C "$HOME/.oh-my-zsh" pull --ff-only origin master || echo "  (oh-my-zsh update skipped or failed)"
    fi

    # zsh-completions
    local completions=$zsh_custom/plugins/zsh-completions
    if [[ -d $completions ]]; then
        git -C "$completions" pull --ff-only origin master || true
    else
        echo "==> Cloning zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions "$completions"
    fi

    # zsh-autosuggestions
    local autosuggestions=$zsh_custom/plugins/zsh-autosuggestions
    if [[ -d $autosuggestions ]]; then
        git -C "$autosuggestions" pull --ff-only origin master || true
    else
        echo "==> Cloning zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions"
    fi
}

# --- Fetch ez-pz theme ---
echo "==> Updating ez-pz theme..."
curl -fsSL 'https://raw.githubusercontent.com/mangosmoothie/ez-pz/master/ez-pz.zsh-theme' \
    -o "$HOME/.oh-my-zsh/themes/ez-pz.zsh-theme" || echo "  (theme download failed)"

# --- Sync dotfiles to home ---
echo "==> Rsyncing dotfiles to ~ ..."
rsync --exclude=".git/" \
      --exclude=".DS_Store" \
      --exclude=".gitignore" \
      --exclude="sync.sh" \
      --exclude="README.md" \
      --exclude="LICENSE" \
      -avh --no-perms "$DOTFILES_DIR/" ~/

source "$HOME/.zshenv" 2>/dev/null || true
source "$HOME/.zshrc" 2>/dev/null || true

echo "==> Done."
