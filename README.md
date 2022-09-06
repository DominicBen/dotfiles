# dotfiles

How to install

git init --bare $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' (add this alias to .bashrc)
config config --local status.showUntrackedFiles no
config 

/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME remote add origin https://github.com/DominicBen/dotfiles.git
