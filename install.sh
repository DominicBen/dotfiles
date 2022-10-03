sudo apt install -y curl neovim zsh nnn neofetch tmux code tlp htop nvtop intel-gpu-tools

sudo apt install gnome-tweaks -y

sudo apt install -y git
git config --global credential.helper store

# oh-my-zsh installation
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#Nvim Install
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
sudo apt install exuberant-ctags

#Tmux Install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#nvm Install

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash


# X settings
xset -dpms
xset s noblank

# Other things to manually install
# Conda - Python Package Manager
# Barrier - Multi Mouse and Keyboard
# Brave - Web browser
# ONLYOFFICE - Office365 Alt
# Nextcloud - file Managment


# House Cleaning items
# Brave - Sync with chain
# VSCode - Sync with chain
# NVim - run :PlugInstall
