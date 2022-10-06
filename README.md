# dotfiles

How to install

git clone --bare https://github.com/DominicBen/dotfiles.git $HOME/.dotfiles


# Remove Existing Files

/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME reset --hard origin/master

/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

bash

/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no




