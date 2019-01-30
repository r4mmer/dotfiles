export PATHDOTFILES="$HOME/.dotfiles"

# create dotfiles dir
cp -r $PWD $PATHDOTFILES

if [ ! -f "$PATHDOTFILES/install_lock" ]; then
    echo "Please install modules first!";
    echo "Run install.sh to install needed modules";
    exit 1;
fi

# setup symlink to dotfiles
ln -s $PATHDOTFILES/bin $HOME/bin
ln -s $PATHDOTFILES/home/bash_profile $HOME/.bash_profile
ln -s $PATHDOTFILES/home/editorconfig $HOME/.editorconfig
ln -s $PATHDOTFILES/home/gitconfig $HOME/.gitconfig

# setup virtualenv hooks and directories
mkdir -p $HOME/projects
mkdir -p $HOME/.virtualenvs
for file in $PATHDOTFILES/virtualenvwrapper/*; do
	ln -s "$file" "$HOME/.virtualenvs/$(basename "$file")"
done;
unset file;

# setup git flow completion
ln -s $PATHDOTFILES/completion/git-flow-completion /etc/bash_completion.d/git-flow
