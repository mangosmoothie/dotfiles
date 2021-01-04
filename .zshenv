export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export JAVA_OPTS='-Dhttps.proxyHost=localhost -Dhttps.proxyPort=4444'
# squidman proxy setup
export http_proxy=http://localhost:4444
export HTTP_PROXY=http://localhost:4444
export https_proxy=http://localhost:4444
export HTTPS_PROXY=http://localhost:4444
export proxy=http://localhost:4444
export no_proxy=localhost,127.0.0.1,.gm.com
# report on long running processes - execution time, etc.
export REPORTTIME=3
alias ag="ag --hidden --ignore .git"
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"

source "$HOME/miniconda3/etc/profile.d/conda.sh"
source "$HOME/.sdkman/bin/sdkman-init.sh"
