# ZSH install
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing OMZ"
    curl -L http://install.ohmyz.sh | zsh
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="muse"/' ./.zshrc
	cd ~/.oh-my-zsh/custom/plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	cd ~
	sed -i 's/plugins=(git)/plugins=(git python screen z zsh-syntax-highlighting)/' ./.zshrc
	touch .z
else
    echo "OMZ already installed"
fi
rm -f ~/.zshrc.pre-oh-my-zsh
