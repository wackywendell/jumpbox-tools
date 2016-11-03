#!/bin/bash

if [[ $SHELL != *"zsh" ]]
then
    echo "You need to have ZSH as your default shell !"
    exit
fi

# Clean everything
cd ~
# Don't delete .ssh otherwise you cannot get in!!
rm -rf .bin* .cache* .chef* .config* .lesshst .oh-my-zsh .zcomp* .zsh*
# In case we are re-running it
rm -rf .jumpbox-tools

# Clone ourselves
git clone https://github.com/wackywendell/jumpbox-tools.git ~/.jumpbox-tools

cd ~/.jumpbox-tools

./installs.sh
./links.sh

exec zsh
. ~/.zshrc
