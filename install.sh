#!/bin/bash

pushd `pwd`

cd ~

echo
echo 'Install manually:'
echo

echo '    - Xcode, see the AppStore'
echo '    - PHP: https://php-osx.liip.ch/'

echo ' Firefox: '
echo '        - Ad blocker plus: https://addons.mozilla.org/en-US/firefox/addon/adblock-plus/'
echo '        - Ghostery: https://addons.mozilla.org/en-US/firefox/addon/ghostery/'
echo
read -p 'ENTER to continue...'
echo

echo 'Installing Homebrew...'
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
brew doctor
brew update
brew upgrade

brew cask install firefox
brew cask install lastpass-universal
brew cask install virtualbox
brew cask install vagrant
brew cask install iterm2
brew cask install dropbox
brew cask install sizeup

echo 'Installing base tools...'
brew install git
brew install wget
brew install nmap
brew install ack
brew install sloccount
brew install tmux
brew install tree
brew install jsl
brew install ctags
brew install archey

# Mysql
# Mariadb is drop-in replacement, also used by default on Openminds servers
brew install mariadb
brew services start mariadb
brew cask install sequel-pro

wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
mv phpunit.phar /usr/local/bin/phpunit

curl -s https://getcomposer.org/composer.phar -o /usr/local/bin/composer
chmod +x /usr/local/bin/composer

echo 'Installing webgrind...'
brew install graphviz # For generating call graphs.
cd ~/Sites
git clone git@github.com:dubgeiser/webgrind.git
cd webgrind/
git remote add upstream git://github.com/jokkedk/webgrind.git

echo 'Installing Capistrano...'
sudo gem install capistrano capistrano-ext colored

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
sudo ln -s ~/bin/wifionoff.sh /usr/bin/wifionoff

echo 'Installing vimconfig...'
git clone git@github.com:dubgeiser/vimconfig.git .vim
cd ~/.vim
git submodule init
git submodule update
git submodule foreach git co master
./update
cd ~
ln -s .vim/vimrc .vimrc
ln -s .vim/gvimrc .gvimrc

# POW dynamic dns
# http://pow.cx/
# THIS SHOULD BE DONE BEFORE INSTALL
# echo 'export POW_DST_PORT=81' >> ~/.powconfig
# (I'm putting this into my tilde /.powconfig, so tilde should be installed
# before pow.)
# Uninstall Pow: curl get.pow.cx/uninstall.sh | sh
curl get.pow.cx | sh

cd ~
git clone git@bitbucket.org:dubgeiser/documents.git Documents

popd

