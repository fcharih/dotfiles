# setup_ubuntu.sh
# Author: Francois Charih <francoischarih@sce.carleton.ca>
#
# Description: Installs the minimum set of dependencies I need
# to work when I boot a new Ubuntu machine.

# Go to home directory
cd $HOME
mkdir temp

# Install the zshell
sudo apt-get install -y zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Install Anaconda
curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
mv Anaconda3-5.2.0-Linux-x86_64.sh temp
sudo bash temp/Anaconda3-5.2.0-Linux-x86_64.sh
sudo chown -R $USER:$USER anaconda3

# Install Node.js and yarn
wget -qO- https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g yarn

## Setup Git
git config --global user.email "francoischarih@sce.carleton.com"
git config --global user.name "Francois Charih"

# Install neovim
sudo apt-get install -y neovim

# Install Vim-Plug and deoplete
pip install neovim
pip install jedi
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim # vim-plug

# Setup .vimrc
mkdir .config
mkdir .config/nvim
vimfilecontent="set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc"
echo "$vimfilecontent" > ~/.config/nvim/init.vim 
ln -s dotfiles/.vimrc .vimrc

# Create symbolic links 
rm $HOME/.zshrc && ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc
rm $HOME/.tmux.conf && ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf
source .zshrc

# Install Docker
sudo apt-get install -y libltdl7
wget -P temp/ https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
sudo dpkg -i temp/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb

# Delete all temporary file
rm -rf temp
