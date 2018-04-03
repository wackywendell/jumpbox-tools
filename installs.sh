# ZSH install
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing OMZ"
	ZSH="$HOME/.oh-my-zsh"
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
	# curl -L http://install.ohmyz.sh | zsh
	cd $ZSH/custom/plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	cd ~
	touch .z
else
    echo "OMZ already installed"
fi
touch ~/.z
