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
      --exclude="cursor/" \
      -avh --no-perms "$DOTFILES_DIR/" ~/

# --- Cursor (VS Code-based) user config via symlink ---
{
    local cursor_user="$HOME/Library/Application Support/Cursor/User"
    local cursor_dot="$DOTFILES_DIR/cursor"
    local cursor_cli="/Applications/Cursor.app/Contents/Resources/app/bin/cursor"

    if [[ -d $cursor_dot && -d $cursor_user ]]; then
        echo "==> Linking Cursor settings from $cursor_dot ..."
        for f in settings.json keybindings.json; do
            if [[ -f $cursor_dot/$f ]]; then
                # Back up a real file once if it isn't already our symlink
                if [[ -e $cursor_user/$f && ! -L $cursor_user/$f ]]; then
                    mv "$cursor_user/$f" "$cursor_user/${f}.bak.$(date +%Y%m%d%H%M%S)"
                fi
                ln -sfn "$cursor_dot/$f" "$cursor_user/$f"
                echo "  linked $f"
            fi
        done

        if [[ -x $cursor_cli && -f $cursor_dot/extensions.txt ]]; then
            echo "==> Ensuring Cursor extensions from extensions.txt ..."
            while IFS= read -r ext || [[ -n $ext ]]; do
                [[ -z $ext || $ext == \#* ]] && continue
                "$cursor_cli" --install-extension "$ext" >/dev/null && echo "  $ext" || echo "  (failed: $ext)"
            done < "$cursor_dot/extensions.txt"
        fi

        # Glass/agent window keybindings live in Cursor's state DB, not settings.json.
        # Without keybindings=vim, Glass disables VSCodeVim (known Cursor bug/behavior).
        local glass_prefs="$cursor_dot/glass-editor-preferences.json"
        local state_db="$cursor_user/globalStorage/state.vscdb"
        if [[ -f $glass_prefs && -f $state_db ]]; then
            echo "==> Setting Glass editor keybindings preference (vim) ..."
            python3 - "$glass_prefs" "$state_db" <<'PY' && echo "  cursor/glass.editorPreferences updated" || echo "  (skipped: could not update state.vscdb)"
import json, sqlite3, sys
prefs_path, db_path = sys.argv[1], sys.argv[2]
desired = json.load(open(prefs_path))
key = "cursor/glass.editorPreferences"
con = sqlite3.connect(db_path, timeout=10)
cur = con.cursor()
row = cur.execute("select value from ItemTable where key=?", (key,)).fetchone()
merged = dict(desired)
if row:
    try:
        existing = json.loads(row[0])
        if isinstance(existing, dict):
            merged = {**existing, **desired}
    except Exception:
        pass
value = json.dumps(merged, separators=(",", ":"))
cur.execute(
    "insert into ItemTable(key,value) values(?,?) on conflict(key) do update set value=excluded.value",
    (key, value),
)
con.commit()
con.close()
PY
        fi
    else
        echo "==> Skipping Cursor link (missing $cursor_dot or $cursor_user)"
    fi
}

source "$HOME/.zshenv" 2>/dev/null || true
source "$HOME/.zshrc" 2>/dev/null || true

echo "==> Done."
