#!/bin/bash

pushd `pwd`

cd ~

echo
echo 'Install manually:'
echo

echo 'NOT YET AVAILABLE in brew caske, install manually:'

            # TODO Better full XCode => brew install macvim needs it.
            # XXX 2014-09-10 brew macvim and brew cask macvim are still behind
            #     the 'normal' MacVim distro, so for now, install it manually.
            #     But might consider shell vim only now since font rendering
            #     seems to be OK now (note: might be due to change of color
            #     scheme which might be more forgiving).
            #     Also, vim has more recent versions than macvim... TBC/D
echo '    - Command line tools for Xcode: https://developer.apple.com/downloads/'

echo '    - Mysql: http://www.mysql.com/downloads/mysql/'
echo '    - MacVim: https://github.com/b4winckler/macvim/downloads'

echo ' Firefox: '
echo '        - Xmarks: http://www.xmarks.com/'
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

brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php

echo 'Installing Homebrew cask...'
# http://caskroom.io/
brew install caskroom/cask/brew-cask

brew cask install firefox
brew cask install lastpass-universal
brew cask install virtualbox
brew cask install vagrant
brew cask install quicksilver
brew cask install iterm2
brew cask install dropbox
brew cask install littleipsum
brew cask install coconutbattery
brew cask install sizeup
brew cask install the-unarchiver

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
brew install archey

# TODO with more and more usage of sneakers, I imagine this may go.
brew install elasticsearch

echo 'Installing PHP...'
brew install php54  --with-mysql --with-intl --with-imap
brew install php54-intl
brew install php54-xdebug
brew install php54-oauth
brew install php54-apc

echo 'Install PHP tooling...'
brew install phploc
brew install phpmd
brew install pdepend
brew install phpunit

echo 'PEAR, play nice with the homebrew PHP...'
chmod -R ug+w `brew --prefix php54`/lib/php
pear config-set php_ini /usr/local/etc/php/5.4/php.ini
pear config-set auto_discover 1
pear update-channels
pear upgrade
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

