#!/bin/sh

echo "Did you :" &&
echo " - resize / partition to fit the whole SD card ?" &&
echo " -> sudo raspi-config to do it and reboot" &&
echo "" &&
echo "If you did I'm proud of you and you should press y to carry on the installation." &&
echo "Install environment for Pi ? (y/n)" &&
read key &&
[ "$key" = "y" ] &&
./setup_pi.sh &&
#./setup_of.sh &&

echo "Done."

