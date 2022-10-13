echo -n "Install for a Desktop Enviorment?"
read x

sudo apt install -y git curl neovim zsh nnn neofetch tmux htop unzip -y
if [ $x -eq 1 ]; then
sudo apt install code tlp nvtop intel-gpu-tools gnome-tweaks -y
fi

git config --global user.name "bdominic00@gmail.com"
git config --global user.email bdominic00@gmail.com

git config --global credential.helper store
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# oh-my-zsh installation
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#Nvim Install
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
sudo apt install exuberant-ctags

#Tmux Install
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#nvm Install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# X settings
if [ $x -eq 1 ]; then
xset -dpms
xset s noblank
fi




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
