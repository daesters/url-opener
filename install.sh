#!/bin/bash

SCRIPTPATH=`pwd`
SCRIPT="URL-opener"

LINK="/usr/local/bin/${SCRIPT,,} "

LOCALPATH="$HOME/.local/bin"
GLOBALPATH="/usr/local/bin"
CMD=${SCRIPT,,}

### Functions

function check_local_path() {
	if [[ $PATH =~ $LOCALPATH ]]
	then
		return 1
	else
		return 0
	fi

}

function copy_script() {
	cp $SCRIPTPATH/$SCRIPT $1/$CMD
}

function copy_desktop() {	
	echo "Copying desktop files..."
	cp web.jpg "$HOME/.local/share/icons/hicolor/128x128/apps/URL-opener.jpg"
	cp "URL-opener.desktop" "$HOME/.local/share/applications/"
}

### Main

check_local_path
res=$?
if [ $res -gt 0 ]
then
	echo "Install in local path"
	copy_script $LOCALPATH	
else
	read -p "Install in global path, needs sudo rights (y/n)?" choice
	case "$choice" in 
	  y|Y ) sudo copy_script $PATH;;
	  * ) echo "abort" && exit;;
	esac
fi

copy_desktop

echo "Done"


