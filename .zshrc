export PATH="/opt/homebrew/bin:$PATH"

# Set editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
    export EDITOR=vi
else
    export EDITOR=nvim
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='eza'
alias gg='lazygit'
alias conf='cd ~/.config/nvim && nvim'
alias vim='nvim'
alias c='clear'
alias start-bs='browser-sync start --config bs-config.js'

# Function
dot() {
    cd ~/dotfiles
    file=$(find . -type f ! -path "*/.git/*" | fzf --height 40% --border)
    [[ -n "$file" ]] && nvim "$file"
}

# Load oh-my-posh 
eval "$(oh-my-posh init zsh --config $HOME/dotfiles/omp.toml)"
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh)"
fi

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

