# setup_ubuntu.sh
# Author: Francois Charih <francoischarih@sce.carleton.ca>
#
# Description: Installs the minimum set of dependencies I need
# to work when I boot a new Ubuntu 18.04 machine.

# Go to home directory
cd $HOME
mkdir temp

# Install the zshell
sudo apt-get install -y zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Anaconda 
curl -o temp/install_anaconda.sh https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh
sudo bash temp/install_anaconda.sh -b # install in silent mode
sudo chown -R $USER:$USER anaconda3

# Install Node.js and yarn
wget -qO- https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g yarn

# Add gitk 
sudo apt-get install gitk

# Install fzf fuzzy file finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
bash $HOME/.fzf/install

# Vim stuff
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim # Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # vim-plug
mkdir .config
sudo chown $USER:$USER .config
sudo mkdir .config/nvim
cat >.config/nvim/init.vim <<EOL
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source $HOME/.vimrc
EOL

# Create symbolic links for my dotfiles
rm $HOME/.vimrc && ln -s dotfiles/.vimrc .vimrc
rm $HOME/.zshrc && ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
rm $HOME/.tmux.conf && ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

source .zshrc

# Install Glances... it's a cool replacement for "top"
pip install glances
pip install neovim # Neovim Python Client
pip install jedi # Jedi for completion

# Install Docker
sudo apt-get install -y libltdl7
wget -P temp/ https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
sudo dpkg -i temp/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
sudo usermod -aG docker $USER

# Delete all temporary file
rm -rf temp

## Setup Git
git config --global user.email "francoischarih@sce.carleton.com"
git config --global user.name "Francois Charih"
