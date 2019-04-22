# ZSH install
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing OMZ"
	ZSH="$HOME/.oh-my-zsh"
	 if which git >/dev/null; then
		git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH
		# curl -L http://install.ohmyz.sh | zsh
		cd $ZSH/custom/plugins
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	else
		wget -q https://github.com/robbyrussell/oh-my-zsh/archive/master.zip -O omz.zip
		unzip -q omz.zip && mv oh-my-zsh-master "$ZSH" && rm omz.zip

		wget -q https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.zip -O zsh-highlight.zip
		unzip -q zsh-highlight.zip && mv zsh-syntax-highlighting-master "$ZSH/custom/plugins/zsh-syntax-highlighting" && rm zsh-highlight.zip

	fi
	cd ~
	touch .z
else
    echo "OMZ already installed"
fi
touch ~/.z
