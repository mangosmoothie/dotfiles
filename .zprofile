export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/bin/apache-storm-1.0.6/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/anaconda3/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_OPTS='-Dhttps.proxyHost=localhost -Dhttps.proxyPort=4444'
# report on long running processes - execution time, etc.
export REPORTTIME=3
alias ag="ag --hidden --ignore .git"
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
eval "$(jenv init -)"
