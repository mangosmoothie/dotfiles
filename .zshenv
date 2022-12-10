export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/projects/.bin:$PATH"
# report on long running processes - execution time, etc.
export REPORTTIME=3
alias ag="ag --hidden --ignore .git"
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
alias rg="rg --hidden -g '!.git'"
source "$HOME/miniconda3/etc/profile.d/conda.sh"

export SDKMAN_DIR="$HOME/.sdkman"
source "$HOME/.sdkman/bin/sdkman-init.sh"
