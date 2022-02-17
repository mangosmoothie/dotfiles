export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/bin:$PATH"
# report on long running processes - execution time, etc.
export REPORTTIME=3
alias ag="ag --hidden --ignore .git"
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
alias gg="rg --hidden -g '!.git'"
alias yarn-login="aws codeartifact login --tool npm --repository ig --domain innovation-garage --region us-east-1 --profile admin-ig-dev-bcbsnc"

source "$HOME/miniconda3/etc/profile.d/conda.sh"

export SDKMAN_DIR="/Users/u135990/.sdkman"
source "$HOME/.sdkman/bin/sdkman-init.sh"

export AWS_CA_BUNDLE="/Users/u135990/.bcbsnc/ca-combined.pem"
export NODE_EXTRA_CA_CERTS="/Users/u135990/.bcbsnc/ca-combined.pem"
export REQUESTS_CA_BUNDLE="/Users/u135990/.bcbsnc/ca-combined.pem"

