#!/bin/bash

# PATHS

SCRIPTPATH=`pwd`
SCRIPT="URL-opener"

LOCALPATH="$HOME/.local/bin"
GLOBALPATH="/usr/local/bin"
CMD=${SCRIPT,,}


ICON="web.jpg"
ICONDEST="$HOME/.local/share/icons/hicolor/128x128/apps/$SCRIPT.jpg"

DESKTOPFILE="URL-opener.desktop"
DESKTOPPATH="$HOME/.local/share/applications/"

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

function copy_script_sudo() {
	sudo cp $SCRIPTPATH/$SCRIPT $1/$CMD
}

function copy_desktop() {	
	echo "Copying desktop files..."
	cp $ICON $ICONDEST
	cp $DESKTOPFILE $DESKTOPPATH
}


### Installation and uninstallation functions

function installation() {
	check_local_path
	res=$?
	if [ $res -gt 0 ]
	then
		echo "Install in local path"
		copy_script $LOCALPATH	
	else
		read -p "Install in global path, needs sudo rights (y/n)?" choice
		case "$choice" in 
		  y|Y ) copy_script_sudo $GLOBALPATH;;
		  * ) echo "abort" && exit;;
		esac
	fi

	copy_desktop

	echo "Done"
}

function uninstallation() {
	rm -f $DESKTOPPATH$DESKTOPFILE
	rm -f $ICONDEST
	rm -f $LOCALPATH/$CMD

	if [ -f $GLOBALPATH/$CMD ]
	then
		sudo rm $GLOBALPATH/$CMD
	fi	
}

### MAIN
if [[ $1 =~ "-u" ]]
then
	echo "Uninstall"
	uninstallation
else
	echo "Installation"
	installation
fi


