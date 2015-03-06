#!/bin/sh

# Script for raspberry pi system installation

# Admitting you are on a fresh install, your default password is raspberry
echo "Upgrading firmware" &&
echo "raspberry" | sudo -S rpi-update &&
echo "Updating and upgrading system..." &&
sudo apt-get clean && sudo apt-get update && sudo apt-get -y --force-yes upgrade &&
echo "Adding mDns Avahi daemon" &&
sudo apt-get install -y --force-yes libnss-mdns &&
echo "Installing basic packages..." &&
sudo apt-get -y --force-yes install zsh vim screen htop x11vnc git scalpel ssh ntp netplug sshfs &&
echo "Configuring zsh and vim..." &&
[ -f etc/zshrc ] && cp etc/zshrc ~/.zshrc 
[ -f etc/vimrc ] && cp etc/vimrc ~/.vimrc 
chsh -s $(which zsh) &&
echo "Configuring git..." &&
git config --global color.status auto &&
git config --global color.branch auto &&
git config --global core.editor vim  &&
git config --list &&
echo "Installing dev env..." &&
sudo apt-get -y --force-yes install build-essential git valgrind gdb cmake pkg-config &&

## Software install

echo "Installing software dev env..." &&
sudo apt-get update && sudo apt-get upgrade -y --force-yes &&
sudo apt-get install -y --force-yes python-pip qtcreator &&

echo "Done."

