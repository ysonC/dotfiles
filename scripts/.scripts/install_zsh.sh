# --- Step 1: Install Zsh  ---
sudo apt install zsh

# --- Step 2: Set Zsh as Default Shell ---
echo "Setting Zsh as the default shell..."
chsh -s "$(which zsh)"

# --- Step 3: Install Zsh Plugins and Pure Prompt ---
echo "Setting up Zsh plugins and Pure prompt..."
mkdir -p "$HOME/.zsh"

# Install Zsh Autosuggestions if not already installed
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
fi

# Install Zsh Syntax Highlighting if not already installed
if [ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$HOME/.zsh/zsh-syntax-highlighting"
fi

# Install Pure prompt if not already installed
if [ ! -d "$HOME/.zsh/pure" ]; then
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi
