# Neovim <3
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update -y
sudo apt install -y neovim
# Fastfetch install
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update -y
sudo apt install -y fastfetch
# nvim lsp
sudo apt install -y python3-venv
sudo apt install -y luarocks 
# install fast node manager
curl -fsSL https://fnm.vercel.app/install | bash
fnm install --lts
# Install Nerd fonts
mkdir -p ~/.local/share/fonts && \
curl -fLo /tmp/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip && \
unzip -o /tmp/Hack.zip -d ~/.local/share/fonts/Hack && \
fc-cache -fv && \
rm /tmp/Hack.zip
# Pip Stuff
sudo apt install -y pip
pip install shell-gpt

#Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
#Various Packages
sudo apt install -y btop
curl https://sh.rustup.rs -sSf | sh
# Lazy Git
sudo add-apt-repository ppa:lazygit-team/daily
sudo apt update
sudo apt install lazygit
