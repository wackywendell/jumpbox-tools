#!/bin/bash
CDIR=~/.jumpbox-tools

rmlink(){
    rm -f $2
    ln -s $CDIR/$1 $2
}

# zsh
rmlink zsh/env ~/.zshenv
rmlink zsh/rc ~/.zshrc
rmlink zsh/login ~/.zlogin
mkdir -p ~/.oh-my-zsh/custom/themes
rmlink zsh/muse-dd.zsh-theme ~/.oh-my-zsh/custom/themes/muse-dd.zsh-theme

# tools
rmlink bin ~/.bin

# ssh
rmlink ssh/rc ~/.ssh/rc
rmlink ssh/config ~/.ssh/config
