# dotfiles

How to install

git clone --bare https://github.com/DominicBen/dotfiles.git $HOME/.dotfiles


#Remove Existing Files
mkdir -p .config-backup && \

/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \

xargs -I{} mv {} .config-backup/{}


/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

bash

config config --local status.showUntrackedFiles no


