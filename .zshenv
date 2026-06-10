export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
# report on long running processes - execution time, etc.
export REPORTTIME=3
export EDITOR=vim
export DO_NOT_TRACK=1
export DISABLE_TELEMETRY=1
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
alias rg="rg --hidden -g '!.git'"
