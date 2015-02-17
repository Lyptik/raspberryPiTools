#!/bin/sh

# Script dd on a SD card

# dd from $1 to $2
# $1 : your path.img (input)
# $2 : /dev/disk1 (output) OSX example

# TODO : add pv -tpreb $1 | sudo dd bs=1m of=$2 &&

[ "$1" = "-h" ] || [ "$1" = "--help" ] || [ $# -ne 2 ] && { echo "Usage : $0 your-image.img" && exit 1; }

echo "Do you really want to dd $1 to $2 ? PLEASE CHECK THAT $2 is the right place ! (y/n)" &&

read -n1 -r -p "" key
echo "" &&

if [ "$key" = 'y' ]; then

	# In case you are using a Mac
	if [ "`uname`" = "Darwin" ] then;
		sudo dd bs=4m if=$1 of=/dev/disk1
		sync
	else
		sudo dd bs=4M if=$1 of=/dev/disk1
		sync
	fi

	echo "If this copy fails, try to dd with bs=1M (considerably longer)"

	echo "Done."
fi