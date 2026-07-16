local scripts_to_source=(
    # ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    # ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
)

for script_file in "${scripts_to_source[@]}"; do
  if [ -r "$script_file" ]; then
    source "$script_file"
  else
    print -P "%F{yellow}Warning:%f Script not found: $script_file"
  fi
done

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE     # don't save lines starting with space
setopt HIST_VERIFY           # expand history refs before running, don't auto-exec
setopt HIST_REDUCE_BLANKS    # trim extra whitespace before saving
setopt SHARE_HISTORY
setopt AUTO_PUSHD
setopt RM_STAR_WAIT
setopt ALWAYS_TO_END         # move cursor to end after completion

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

#searching
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search


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


export PATH="$PATH:/opt/nvim/bin"
export PATH="$PATH:/Users/connoraubry/go/bin"
export PATH="$PATH:/Users/connoraubry/.bin/zig"
export PATH="$PATH:$HOME/.local/bin"
alias ls="gls --group-directories-first --color=auto"
alias node-ts='node --loader ts-node/esm'
alias love="/Applications/love.app/Contents/MacOS/love"


eval "$(starship init zsh)"
