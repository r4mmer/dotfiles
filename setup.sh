#!/usr/bin/env bash

IAM=$(whoami)
PATHDOTFILES="$HOME/.dotfiles"

# XXX: i dont want bashrc in my dotfiles for now
if ! grep -q "source ~/.bash_profile" "$HOME/.bashrc"; then
	echo "source ~/.bash_profile" >> "$HOME/.bashrc"
fi

function _install_dotdeps () {
	if [ ! -f "/etc/sudoers.d/$IAM" ]; then
		echo -e "Please configure your user as a suder:\n\tsudo visudo -f /etc/sudoers.d/$IAM\n\n\t$IAM ALL=(ALL) NOPASSWD: ALL"
		exit 1
	fi

	INSTALLED_MODULES=0
	sudo apt-get install -y $( cat "$PATHDOTFILES/install_requires.txt" | tr '\r\n' ' ' )  && INSTALLED_MODULES=1

	if [ "$INSTALLED_MODULES" = 1 ]; then
		echo -e "\nModules were installed successfully"
		return 0
	else
		echo -e "!!!WARNING!!!\n\nFailed installing modules\nCheck output and fix installation errors, or skip installation"
		return 1
	fi
}

function _create_dotsymlink () {
	# setup symlink to dotfiles
	SYML_ERRORS=()
	for symfile in $PATHDOTFILES/home/*; do
		homefile="$HOME/.$(basename $symfile)"
		if [ ! -e "$homefile" ]; then
			echo "$homefile"
			ln -s "$symfile" "$homefile"
		else
			if [ ! -L "$homefile" ]; then
				SYML_ERRORS+=("$homefile")
			fi
		fi
		unset homefile
	done;
	unset symfile
	if [ ! ${#SYML_ERRORS[@]} -eq 0 ]; then
		echo "please delete ($SYML_ERRORS) before continuing..."
		return ${#SYML_ERRORS[@]}
	fi
	unset SYML_ERRORS

	if [ ! -e "$HOME/.bin" ]; then
		ln -s $PATHDOTFILES/bin $HOME/.bin
	fi

	# setup virtualenv hooks and directories
	mkdir -p $HOME/projects
	mkdir -p $HOME/.virtualenvs
	for symfile in $PATHDOTFILES/virtualenvwrapper/*; do
		# ln -s "$file" "$HOME/.virtualenvs/$(basename "$file")"
		homefile="$HOME/.virtualenvs/$(basename "$symfile")"
		if [ ! -e "$homefile" ]; then
			echo "$homefile"
			ln -s "$symfile" "$homefile"
		else
			if [ ! -L "$homefile" ]; then
				SYML_ERRORS+=("$homefile")
			fi
		fi
		unset homefile
	done;
	unset symfile;
	if [ ! ${#SYML_ERRORS[@]} -eq 0 ]; then
		echo "files $SYML_ERRORS were not symlinked to dotfiles because they already exist."
	fi
	unset SYML_ERRORS

	# setup git flow completion
	# ln -s $PATHDOTFILES/completion/git-flow-completion /etc/bash_completion.d/git-flow

}

function _install_nvim () {
	INSTALLED_MODULES=0
	sudo apt-get install -y $( cat "$PATHDOTFILES/install_requires.txt" | tr '\r\n' ' ' )  && INSTALLED_MODULES=1

	if [ "$INSTALLED_MODULES" = 1 ]; then
		echo -e "\nNeoVIM installed successfully"
	else
		echo -e "!!!WARNING!!!\n\nFailed installing modules\nCheck output and fix installation errors, or skip installation"
		return 1
	fi

	mkdir -p "$HOME/.config/nvim"
	if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	fi
	if [ ! -e "$HOME/.config/nvim/init.vim" ]; then
		ln -s "$PATHDOTFILES/nvim/init.vim" "$HOME/.config/nvim/init.vim"
	else
		if [ ! -L "$HOME/.config/nvim/init.vim" ]; then
			echo -e "Delete init.vim to continue..."
			return 1
		fi
	fi

	echo "Installing python3 packages for neovim..."
	# mostly for https://github.com/ncm2/ncm2 and yarp
	pip3 freeze | grep neovim || sudo pip3 install --user neovim pynvim
}

function _update_dotfiles () {
	cd $PATHDOTFILES
	STASH_OUT="$(git stash -u)"
	git pull
	if [ ! "$STASH_OUT" = "No local changes to save" ]; then
		git stash pop || echo -e "\nThere were conflicts with your configs\nFix them in $PATHDOTFILES:\n\tgit mergetool"
	fi
	cd -
}

function _create_dotpath () {
	# create dotfiles dir
	if [ ! -d "$PATHDOTFILES" ]; then
		cp -r $PWD $PATHDOTFILES;
	fi
}


VALID_COMANDS="install, update, create, symlink"
case $1 in
"install")
	_install_dotdeps
	;;
"update")
	_update_dotfiles
	;;
"create")
	_create_dotpath
	_create_dotsymlink
	;;
"symlink")
	_create_dotsymlink
	;;
"nvim")
        _install_nvim
        ;;
"")
	echo "no command given, use ($VALID_COMANDS)"
	;;
*)
	echo "$1 is not a valid command, use ($VALID_COMANDS)"
	exit 1
	;;
esac
