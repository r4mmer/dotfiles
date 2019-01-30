PATHDOTFILES="$HOME/.dotfiles"

INSTALLED_MODULES="not yet"
FAIL_MSG="!!!WARNING!!!\n\nFailed installing modules\nIf you want to continue anyway run:\n\ttouch \"\$HOME/.dotfiles/install_lock\"\n"
sudo apt-get install $( cat "$PATHDOTFILES/install_requires.txt" | tr '\r\n' ' ' )  && INSTALLED_MODULES="ok" || echo -e $FAIL_MSG

if [ "$INSTALLED_MODULES" = "ok" ]; then
	touch "$PATHDOTFILES/install_lock"
	echo -e "\nModules were installed successfully\nRun setup.sh to continue..."
else
	echo "Please install modules to continue"
fi
