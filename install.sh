#!/usr/bin/env bash

pushd `pwd`

cd ~

mkdir -p ~/Projects

echo
echo 'Install manually (BEFORE CONTINUING WITH THE INSTALL):'
echo
echo 'Firefox with lastpass and Ublock'
echo
echo 'Homebrew, see their website'
echo
read -p 'ENTER to continue...'
echo

# Use a newer Bash as login shell
brew install bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/bash

brew install starship
brew install git
brew install git-delta
brew install wget
brew install nmap
brew install scc
brew install asciidoc
brew install tmux
brew install tree
brew install jsl
brew install ctags
brew install ripgrep
brew install figlet
brew install ngrep
brew install fzf
/usr/local/opt/fzf/install --all
brew install openssl
brew install htop
brew install erlang
brew install jq
brew install jp2a
brew install gnu-sed
brew install gpatch
brew install gnupg
brew install sqlite
brew install lorem
brew install ansible ansible-lint
brew install shellcheck shfmt
brew install pandoc
brew install gource
brew install gnuplot
brew install entr
brew install python3
brew install virtualbox virtualbox-extension-pack
brew install vagrant
brew install vlc
brew install wireshark
brew install dropbox
brew install sizeup
brew install java

brew tap homebrew/cask-fonts
brew install font-symbols-only-nerd-font
brew install font-ibm-plex
brew install font-iosevka
brew install kitty
brew install stow
brew install fd

brew install --with-plugins jmeter
brew install npm bower
brew install nvm
npm install -g yarn

# echo 'Installing MacTex distribution'
# echo 'This will take a long time and eats gigabytes of diskspace.'
# brew cask install mactex

# Mysql
# Mariadb is drop-in replacement, also used by default on Openminds servers
brew install mariadb
brew services start mariadb
brew cask install sequel-pro

curl -s https://getcomposer.org/composer.phar -o /usr/local/bin/composer
chmod +x /usr/local/bin/composer

echo 'Installing webgrind...'
brew install graphviz # For generating call graphs.
cd ~/Sites
git clone git@github.com:dubgeiser/webgrind.git
cd webgrind/
git remote add upstream git://github.com/jokkedk/webgrind.git
git pull upstream master
git push origin master

echo 'Installing tilde...'
cd ~
rm -f .bashrc
rm -f .bash_profile
rm -f .gitconfig
rm -f .inputrc
rm -f .tmux.conf
cd ~/Projects/
git clone git@github.com:dubgeiser/tilde.git
cd tilde
./install
cd ../../


echo 'Setting up Neovim...'
echo 'Plugins should be installed first time Neovim is started.'
brew install --HEAD neovim
git clone git@github.com:dubgeiser/vimconfig.git .config/nvim

# Need this for Neovim to support Python 3.
python3 -m pip install --user --upgrade pynvim

cd ~
sudo gem install asciidoctor-pdf

popd
