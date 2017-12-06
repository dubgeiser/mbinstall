#!/bin/bash

pushd `pwd`

cd ~

echo
echo 'Install manually:'
echo '    - Xcode, see the AppStore'
echo '    - PHP: https://php-osx.liip.ch/'
echo
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
brew install ag
brew install figlet
brew install ngrep
brew install fzf
/usr/local/opt/fzf/install --all
brew install openssl
brew install htop
brew install erlang
brew install jq
brew cask install firefox
brew cask install lastpass-universal
brew cask install virtualbox
brew cask install vagrant
brew cask install iterm2
brew cask install dropbox
brew cask install sizeup
brew cask install chefdk

# echo 'Installing MacTex distribution'
# echo 'This will take a long time and eats gigabytes of diskspace.'
# brew cask install mactex

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

echo 'Setting up Vim...'
brew install macvim --override-system-vim
git clone git@github.com:dubgeiser/vimconfig.git .vim
~/.vim/install

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

