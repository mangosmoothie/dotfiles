# get / update oh-my-zsh plugins
function () {
    local zsh_custom=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    local completions=$zsh_custom/plugins/zsh-completions
    ( cd ~/.oh-my-zsh ; git pull origin master )
    if [ -d $completions ]; then
        ( cd $completions ; git pull origin master )
    else
        git clone \
            https://github.com/zsh-users/zsh-completions \
            $completions;
    fi

    local autosuggestions=$zsh_custom/plugins/zsh-autosuggestions
    if [ -d $autosuggestions ]; then
        ( cd $autosuggestions ; git pull origin master )
    else
        git clone \
            https://github.com/zsh-users/zsh-autosuggestions \
            $autosuggestions;
    fi
}

# get ez-pz zsh-theme
function() {
    curl -fsSL 'https://raw.githubusercontent.com/mangosmoothie/ez-pz/master/ez-pz.zsh-theme' -o ~/.oh-my-zsh/themes/ez-pz.zsh-theme;
}

# sync all files and source shell dotfiles
function () {
	  rsync --exclude ".git/" \
		--exclude ".DS_Store" \
                --exclude ".gitignore"
		--exclude "sync.sh" \
		--exclude "README.md" \
		--exclude "LICENSE" \
		-avh --no-perms . ~;

    source ~/.zprofile;
    source ~/.zshrc;
}
echo "jobs done.";
