#!/bin/bash

# Variables
REPO_URL="https://github.com/Nugumanov/workspace.git"
CONFIG_DIR="$HOME/workspace"
LOGFILE="$HOME/setup-log.txt"
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
DOTFILES_DIR="$HOME/dotfiles"
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

# Log setup
exec > >(tee -a $LOGFILE) 2>&1

# Functions

install_packer() {
    # Check if Packer is installed
    if [ ! -d "$PACKER_PATH" ]; then
        echo "Installing Packer..."
        git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
        echo "Packer installed."
    else
        echo "Packer is already installed."
    fi
}

install_neovim() {
    if ! command -v nvim &> /dev/null; then
        echo "Installing Neovim..."
        brew install neovim
    else
        echo "Neovim is already installed."
    fi
}

install_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        echo "Homebrew is already installed."
    fi
}

install_zsh() {
    if ! command -v zsh &> /dev/null; then
        echo "Installing Zsh..."
        brew install zsh
    else
        echo "Zsh is already installed."
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "Oh My Zsh is already installed."
    fi

    if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
        echo "Oh My Zsh installation seems incomplete. Reinstalling..."
        rm -rf $HOME/.oh-my-zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install plugins
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    else
        echo "zsh-syntax-highlighting is already installed."
    fi

    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    else
        echo "zsh-autosuggestions is already installed."
    fi
}

install_kitty() {
    if ! command -v kitty &> /dev/null; then
        echo "Installing Kitty terminal..."
        brew install kitty
    else
        echo "Kitty is already installed."
    fi
}

install_tmux() {
    if ! command -v tmux &> /dev/null; then
        echo "Installing tmux..."
        brew install tmux
    else
        echo "tmux is already installed."
    fi
}

clone_configs() {
    if [ -d "$CONFIG_DIR" ]; then
        echo "Configuration directory already exists. Pulling the latest changes..."
        cd $CONFIG_DIR && git pull
    else
        echo "Cloning configuration repository..."
        git clone --recurse-submodules $REPO_URL $CONFIG_DIR
    fi
}

apply_configs() {
    echo "Applying configuration files..."

    # Link configuration files
    ln -sf $CONFIG_DIR/.zshrc $HOME/.zshrc
    ln -sf $CONFIG_DIR/.bashrc $HOME/.bashrc
    ln -sf $CONFIG_DIR/.tmux.conf $HOME/.tmux.conf
    ln -sf $CONFIG_DIR/.tmux.reset.conf $HOME/.tmux.reset.conf
    ln -sf $CONFIG_DIR/.vimrc $HOME/.vimrc

    # Ensure Kitty configuration directory exists
    mkdir -p $HOME/.config/kitty

    # Link Kitty configuration files
    ln -sf $CONFIG_DIR/kitty.conf $HOME/.config/kitty/kitty.conf
    ln -sf $CONFIG_DIR/kitty-keys.conf $HOME/.config/kitty/kitty-keys.conf
    ln -sf $CONFIG_DIR/kitty-session.conf $HOME/.config/kitty/kitty-session.conf
    ln -sf $CONFIG_DIR/kitty-tabs.conf $HOME/.config/kitty/kitty-tabs.conf
    ln -sf $CONFIG_DIR/kitty-layout.conf $HOME/.config/kitty/kitty-layout.conf
    ln -sf $CONFIG_DIR/theme.conf $HOME/.config/kitty/theme.conf

    # Ensure Neovim configuration directory exists
    mkdir -p $HOME/.config/nvim/lua
    mkdir -p $HOME/.config/nvim/lua/plugin-config

    # Link Neovim Lua configuration files individually
    ln -sf $CONFIG_DIR/nvim/init.lua $HOME/.config/nvim/init.lua
    ln -sf $CONFIG_DIR/nvim/lua/plugins.lua $HOME/.config/nvim/lua/plugins.lua
    ln -sf $CONFIG_DIR/nvim/lua/settings.lua $HOME/.config/nvim/lua/settings.lua
    ln -sf $CONFIG_DIR/nvim/lua/mappings.lua $HOME/.config/nvim/lua/mappings.lua
    ln -sf $CONFIG_DIR/nvim/lua/autocmds.lua $HOME/.config/nvim/lua/autocmds.lua
    ln -sf $CONFIG_DIR/nvim/lua/colors.lua $HOME/.config/nvim/lua/colors.lua

    # Link plugin-specific configurations for Neovim
    ln -sf $CONFIG_DIR/nvim/lua/plugin-config/fern.lua $HOME/.config/nvim/lua/plugin-config/fern.lua
    ln -sf $CONFIG_DIR/nvim/lua/plugin-config/airline.lua $HOME/.config/nvim/lua/plugin-config/airline.lua

    # Ensure submodules are updated
    cd $CONFIG_DIR
    git submodule update --init --recursive

    # Link scripts
    mkdir -p $HOME/scripts
    ln -sf $CONFIG_DIR/scripts/spt_status.sh $HOME/scripts/spt_status.sh
    ln -sf $CONFIG_DIR/scripts/neighboring_window.py $HOME/scripts/neighboring_window.py
    ln -sf $CONFIG_DIR/scripts/pass_keys.py $HOME/scripts/pass_keys.py

    # Ensure scripts are in the correct place for Kitty
    ln -sf $HOME/scripts/pass_keys.py $HOME/.config/kitty/pass_keys.py
    ln -sf $HOME/scripts/neighboring_window.py $HOME/.config/kitty/neighboring_window.py
}

sync_neovim_plugins() {
    # Run this after Packer is installed
    if command -v nvim &> /dev/null; then
        echo "Syncing Neovim plugins..."
        nvim --headless -c 'PackerSync' -c 'qa'
    fi
}

set_default_shell() {
    if [ "$SHELL" != "/bin/zsh" ]; then
        echo "Setting Zsh as the default shell..."
        chsh -s /bin/zsh
    else
        echo "Zsh is already the default shell."
    fi
}

# Main script execution
install_homebrew
install_kitty
install_zsh
install_tmux

install_neovim
install_packer

clone_configs
apply_configs

sync_neovim_plugins

set_default_shell

echo "Setup complete! Please restart your terminal."
