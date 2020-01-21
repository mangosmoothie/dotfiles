export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)
# report on long running processes - execution time, etc.
export REPORTTIME=3
alias ag="ag --hidden --ignore .git"
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
