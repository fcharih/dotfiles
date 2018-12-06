# setup_ubuntu.sh
# Author: Francois Charih <francoischarih@sce.carleton.ca>
#
# Description: Installs the minimum set of dependencies I need
# to work when I boot a new Ubuntu 18.04 machine.

# Go to home directory
cd $HOME
mkdir temp

# Install git, gitk and setup
sudo apt-get install -y git
sudo apt-get install gitk
git config --global user.email "francoischarih@sce.carleton.com"
git config --global user.name "Francois Charih"

# Install useful utils
sudo apt-get install -y wget curl

# Install Anaconda 
curl -o temp/install_anaconda.sh https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh
sudo bash temp/install_anaconda.sh -b # install in silent mode
sudo chown -R $USER:$USER anaconda3

# Install Node.js and yarn
wget -qO- https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g yarn

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
if [ ! -f $HOME/.vimrc ]; then rm $HOME/.vimrc; fi
ln -s dotfiles/.vimrc .vimrc # Create symlink

# Install tmux
sudo apt-get install -y tmux
if [ ! -f $HOME/.tmux.conf ]; then rm $HOME/.tmux.conf; fi
ln -s $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

# Install python-based packages
source .zshrc # Need to source, otherwise, pip will not be on path
pip install glances
pip install neovim # Neovim Python Client
pip install jedi # Jedi for completion

# Install Docker and docker-compose
sudo apt-get install -y libltdl7
wget -P temp/ https://download.docker.com/linux/ubuntu/dists/bionic/pool/stable/amd64/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
sudo dpkg -i temp/docker-ce_18.06.1~ce~3-0~ubuntu_amd64.deb
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER

# Delete all temporary file
rm -rf temp

# Install the zshell (but do not source)
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/\s*env\s\s*zsh\s*/d')"
if [ ! -f $HOME/.zshrc ]; then rm $HOME/.zshrc; fi
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

# Install useful software
sudo apt-get install -y inkscape gimp thunderbird dropbox
sudo add-apt-repository ppa:smathot/cogscinl
sudo apt-get update
sudo apt-get install zotero-standalone

# Never suspend computer
sudo cat > /etc/polkit-1/localauthority/50-local.d/com.ubuntu.disable-suspend.pkla <<EOL
[Disable suspend (upower)]
Identity=unix-user:*
Action=org.freedesktop.upower.suspend
ResultActive=no
ResultInactive=no
ResultAny=no

[Disable suspend (logind)]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend
ResultActive=no
ResultInactive=no
ResultAny=no

[Disable suspend when others are logged in (logind)]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-multiple-sessions
ResultActive=no
ResultInactive=no
ResultAny=no   
EOL

sudo apt-get install -y fonts-powerline
# Source!
source .zshrc
