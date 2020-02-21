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

function create_link() {
	ln -s $SCRIPTPATH/$SCRIPT $1/$CMD
}


### Main

check_local_path
res=$?
if [ $res -gt 0 ]
then
	echo "Install in local path"
	create_link $LOCALPATH	
else
	read -p "Install in global path, needs sudo rights (y/n)?" choice
	case "$choice" in 
	  y|Y ) sudo create_link $PATH;;
	  * ) echo "abort" && exit;;
	esac
fi
#sudo ln -s $SCRIPTPATH/$SCRIPT $LINK
