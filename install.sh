PATHDOTFILES="$HOME/.dotfiles"

INSTALLED_MODULES="not yet"
FAIL_MSG="!!!WARNING!!!\n\nFailed installing modules\nIf you want to continue anyway run:\n\ttouch \"\$HOME/.dotfiles/install_lock\"\n"
echo "sudo apt-get install $( cat "$PATHDOTFILES/install_requires.txt" | tr '\r\n' ' ' )"  && INSTALLED_MODULES="ok" && echo -e $FAIL_MSG

if [ $INSTALLED_MODULES = "ok" ]; then
	echo "Modules were installed";
	touch "$PATHDOTFILES/install_lock"
else
	echo "Please install modules to continue";
fi
