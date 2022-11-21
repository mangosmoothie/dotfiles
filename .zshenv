export ZSH="$HOME/.oh-my-zsh"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/projects/.bin:$PATH"
# report on long running processes - execution time, etc.
export REPORTTIME=3
alias ag="ag --hidden --ignore .git"
alias lg="git log --color --pretty=format:'%C(auto)%h %Cred %<(10,trunc)%an %Creset%C(auto)%s %Cgreen(%cr,%ar) %Creset%C(auto)%d'"
alias rg="rg --hidden -g '!.git'"
alias yarn-login="aws codeartifact login --tool npm --repository ig --domain innovation-garage --region us-east-1 --profile ig-dev-bcbsnc"
alias mvn-login='export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain innovation-garage --domain-owner 428054311210 --region us-east-1 --query authorizationToken --profile ig-dev-bcbsnc --output text`'
source "$HOME/projects/.miniconda3/etc/profile.d/conda.sh"

export SDKMAN_DIR="$HOME/projects/.sdkman"
source "$HOME/projects/.sdkman/bin/sdkman-init.sh"
export JAVA_HOME=$(/usr/libexec/java_home)

export AWS_CA_BUNDLE="$HOME/.bcbsnc/ca-combined.pem"
export NODE_EXTRA_CA_CERTS="$HOME/.bcbsnc/ca-combined.pem"
export REQUESTS_CA_BUNDLE="$HOME/.bcbsnc/ca-combined.pem"
export XDG_CONFIG_HOME="$HOME/projects/.nvm"
