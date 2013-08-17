#!/bin/bash

pushd `pwd`

cd ~

echo
echo 'Install manually:'
echo
echo '    - Quicksilver https://qsapp.com/'
echo '    - Command line tools for Xcode: https://developer.apple.com/downloads/'
echo '    - Fire Fox: http://www.mozilla.org/en-US/firefox/new/'
echo '        - Last pass: https://lastpass.com/'
echo '        - Xmarks: http://www.xmarks.com/'
echo '        - FireBug: http://getfirebug.com/'
echo '        - Ad blocker plus: https://addons.mozilla.org/en-US/firefox/addon/adblock-plus/'
echo '        - Ghostery: https://addons.mozilla.org/en-US/firefox/addon/ghostery/'
echo
echo '    - Mysql: http://www.mysql.com/downloads/mysql/'
echo '    - MacVim: https://github.com/b4winckler/macvim/downloads'
echo '    - iTerm2: http://www.iterm2.com  (http://code.google.com/p/iterm2/downloads/list)'
echo '    - CoconutBattery: http://www.coconut-flavour.com/coconutbattery/'
echo '    - DropBox: https://www.dropbox.com/'
echo '    - SizeUp: http://www.irradiatedsoftware.com/sizeup/'
echo
echo 'Make sure all versions in the file paths and package names are still'
echo 'correct and up to date.'
read -p 'ENTER to continue...'
echo

echo 'Installing Homebrew...'
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
brew doctor
brew update
brew upgrade

brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

echo 'Installing base tools...'
brew install autoconf automake apple-gcc42
brew install git
brew install wget
brew install nmap
brew install ack
brew install sloccount
brew install asciidoc
brew install source-highlight
brew install tmux
brew install tree
brew install jsl
brew install ctags

echo 'Installing PHP...'
brew install php54  --with-mysql --with-intl --with-imap
brew install php54-intl
brew install php54-xdebug
brew install php54-oauth
brew install php54-apc

echo 'PEAR, play nice with the homebrew PHP...'
chmod -R ug+w `brew --prefix php54`/lib/php
pear config-set php_ini /usr/local/etc/php/5.4/php.ini
pear config-set auto_discover 1
pear update-channels
pear upgrade
pear channel-discover pear.phpunit.de
pear install --alldeps phpunit/phpunit PHP_Codesniffer
brew unlink php54
brew link php54
echo 'If installed PEAR tools cannot be executed, add "`brew --prefix php54`/bin" to $PATH'

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

echo 'Installing vimconfig...'
git clone git@github.com:dubgeiser/vimconfig.git .vim
cd ~/.vim
git submodule init
git submodule update
git submodule foreach git co master
cd ~/.vim/bundle/powerline/
git co develop
cd ~/.vim
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

popd

