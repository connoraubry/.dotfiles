#updated zshrc that skips omz. Targeting speed and only the completions that I need

# use arrow keys to search history
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

autoload -Uz select-word-style
select-word-style normal
zstyle ':zle:*' word-style unspecified

# Initialize completion system
autoload -Uz compinit
compinit
# Smart case matching - lowercase matches both cases
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# Menu selection for multiple matches
zstyle ':completion:*' menu select
# Error tolerance in completion
zstyle ':completion:*' completer _complete _approximate




export EDITOR=nvim
alias ls='ls --color=auto'
alias ll='ls -alF'

alias vim=nvim
alias python=python3

#virtualenv 
alias va="source venv/bin/activate"
alias vd="deactivate"
alias vc="python3 -m venv venv"

# lazy load nvm
lazy_nvm(){
    unset -f nvm node npm npx corepack
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm() {lazy_nvm; nvm "$@";}
node() {lazy_nvm; node "$@";}
npm() {lazy_nvm; npm "$@";}
npx() {lazy_nvm; npx "$@";}
