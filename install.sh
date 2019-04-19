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

brew install git
brew install wget
brew install nmap
brew install ack
brew install sloccount
brew install asciidoctor
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
brew cask install firefox
brew cask install virtualbox virtualbox-extension-pack
brew cask install vagrant
brew cask install vlc
brew cask install wireshark
brew cask install iterm2-beta
brew cask install dropbox
brew cask install sizeup
brew cask install chefdk
brew cask install java
brew cask install keepassxc
brew cask install krita
brew cask install flux
brew tap homebrew/cask-fonts
brew cask install font-ibm-plex

brew install --with-plugins jmeter

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

/usr/local/bin/composer global require squizlabs/php_codesniffer '*'
/usr/local/bin/composer global require phpmd/phpmd '*'
/usr/local/bin/composer global require phpstan/phpstan-shim '*'
/usr/local/bin/composer global require hirak/prestissimo '*'
/usr/local/bin/composer global require phpunit/phpunit '*'

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
