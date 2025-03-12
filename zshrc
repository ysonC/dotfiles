# Path
export PATH="$PATH:/opt/nvim/nvim-linux-arm64/bin/"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/snap/bin"
export PATH=$PATH:/usr/local/go/bin
fpath+=($HOME/.zsh/pure)

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_VERIFY

# Aliases
alias bat="batcat"
alias n="nvim"
alias c="clear"
alias lg="lazygit"
alias e="exit"
alias ls="eza --long --no-time --no-user --no-permissions  --icons=always --group-directories-first"
alias la="eza --long --icons=always --group-directories-first"
alias t="tmux"

# Alias for kubectl
alias k="kubectl"
alias hl="cd ~/super-homelab"
alias kdr="k apply --dry-run=client -f ."
alias img="kitty +kitten icat"

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load NVM
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load NVM bash completion

# Prompt
export PURE_GIT_PULL=1
export PURE_CMD_MAX_EXEC_TIME=99999
autoload -U promptinit; promptinit
prompt pure
# Clear the username from Pure’s left prompt state.
# This prevents Pure from adding it to the left prompt.
prompt_pure_state[username]=""

# Now set the right prompt to display the username.
# %n prints the username and %m prints the short hostname.
RPROMPT='%F{242}%m%f'

# Load Plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Setup fzf key bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_OPTS="--preview 'batcat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Load Neofetch
# neofetch
# Test git push
#
