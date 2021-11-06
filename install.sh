#!/usr/bin/env bash

pushd `pwd`

cd ~

echo
echo 'Install manually (BEFORE CONTINUING WITH THE INSTALL):'
echo '    - Xcode, see the AppStore'
echo '    - PHP: https://php-osx.liip.ch/'
echo
echo ' Firefox (after install is done): '
echo '        - Ublock: https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/'
echo '        - Moo Later: https://addons.mozilla.org/en-US/firefox/addon/moo-later/'
echo
read -p 'ENTER to continue...'
echo

echo 'Installing Homebrew...'
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
brew doctor
brew update
brew upgrade

# Use a newer Bash as login shell
brew install bash
echo '/usr/local/bin/bash' | sudo tee -a /etc/shells > /dev/null
chsh -s /usr/local/bin/bash

brew install starship
brew install git
brew install wget
brew install nmap
brew install ack
brew install scc
brew install asciidoc
brew install tmux
brew install tree
brew install jsl
brew install ctags
brew install the_silver_searcher
brew install figlet
brew install ngrep
brew install fzf
/usr/local/opt/fzf/install --all
brew install openssl
brew install htop
brew install erlang
brew install jq
brew install gnu-sed
brew install gnupg
brew install sqlite
brew install lorem
brew install ansible ansible-lint
brew install shellcheck shfmt
brew install pando
brew install gource
brew install gnuplot
brew install entr
brew install python3
brew cask install firefox
brew cask install virtualbox virtualbox-extension-pack
brew cask install vagrant
brew cask install vlc
brew cask install wireshark
brew cask install dropbox
brew cask install sizeup
brew cask install chefdk
brew cask install java
brew cask install krita
brew tap homebrew/cask-fonts
brew cask install font-ibm-plex
brew install font-iosevka
brew install font-iosevka-nerd-font
brew install kitty

brew install --with-plugins jmeter

brew install npm bower
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
git init
git remote add origin git@github.com:dubgeiser/tilde.git
git pull origin master && git fetch

echo 'Setting up Neovim...'
echo 'Plugins should be installed first time Neovim is started.'
brew install neovim
git clone git@github.com:dubgeiser/vimconfig.git .config/nvim

# Need this for Neovim to support Python 3.
python3 -m pip install --user --upgrade pynvim

echo 'Setup language servers for LSP in Neovim.'
npm install -g pyright
npm install -g intelephense
yarn global add ansible-language-server

# TODO I _think_ this can be deleted, but not 100% sure anymore :-|
# POW dynamic dns
# http://pow.cx/
# THIS SHOULD BE DONE BEFORE INSTALL
# echo 'export POW_DST_PORT=81' >> ~/.powconfig
# (I'm putting this into my tilde /.powconfig, so tilde should be installed
# before pow.)
# Uninstall Pow: curl get.pow.cx/uninstall.sh | sh
# curl get.pow.cx | sh

cd ~
sudo gem install asciidoctor-pdf

popd
