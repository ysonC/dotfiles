# Path
export PATH="$PATH:/opt/nvim/nvim-linux-arm64/bin/"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:/snap/bin"
fpath+=($HOME/.zsh/pure)

# History
HISTFILE=~/.zsh_history
HISTZIE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# Aliases
alias bat="batcat"
alias n="nvim"
alias la="ls -la --color=auto"
alias ls="ls --color=auto"
alias c="clear"
alias lg="lazygit"
alias e="exit"
alias k="kubectl"

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

