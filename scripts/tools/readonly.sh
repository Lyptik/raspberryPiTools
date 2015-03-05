#!/bin/sh

# This script changes your raspberry pi as a readonly system
# Use it at your own risk

# Error out if anything fails
set -e

# Make sure script is run as root
if [ "$(id -u)" != "0" ]; then
	echo "Must be run as root ! Try : sudo $0"
	exit 1
fi

# Check if script has already been run

key=n

if [ `cat /etc/default/rcS | grep -x "RAMTMP=yes"` ]; then
	
	echo "Your system seems to be already readonly able ! We strongly suggest to exit right now !" &&
	echo "Are you sure you want to continue ? (y/n)" &&
        read  -r -p "" key
        echo "" &&

        [ "$key" != "y" ] && exit 1

	echo "You are continuing at your own risk ! good luck !"
fi

echo "Disabling swap"

dphys-swapfile swapoff
dphys-swapfile uninstall
update-rc.d dphys-swapfile disabl

echo "Modifying ftab and config to mount partition in readonly"

# Prevent system trying to rm tmp file during boot
sed -i 's/#TMPTIME=0/TMPTIME=-1/' /etc/default/rcS
echo "RAMTMP=yes" >> /etc/default/rcS

sed -i '2s/defaults/defaults,ro/' /etc/fstab
sed -i '3s/noatime/noatime,ro/' /etc/fstab

echo "tmpfs           /tmp            tmpfs   nodev,nosuid,size=30M,mode=1777    0    0
tmpfs           /var/log           tmpfs   nodev,nosuid,size=30M,mode=1777    0    0" >> fstab

sed -i '60s/-f/-L/' /etc/init.d/hwclock.sh

echo 'BLKID_FILE="/var/local/blkid.tab"' >> /etc/environment

rm /etc/mtab
ln -s /proc/self/mounts /etc/mtab

echo "Not using resolv.conf standard way for dns resolving..."
rm -rf /etc/network/run
dpkg-reconfigure ifupdown
apt-get update
apt-get install resolvconf

if [ -f /etc/init.d/supervisor ]; then
	
	echo "You seem to have supervisor installed, Adding a fix enabling supervisor to work correctly with a readonly system"
	sed -i '95 i\        mkdir -p /var/log/supervisor' /etc/init.d/supervisor
else
	echo "  /!\ WARNING : You do not have supervisor installed, if you want to install it later, you will probably need the hotfix contained in this script"
fi

echo "Installing tools to easy remount in readonly or readwrite"

echo "mount -o remount,rw /\nmount -o remount,rw /boot" > /usr/local/bin/remountrw
chmod +x /usr/local/bin/remountrw

echo "mount -o remount,ro /\nmount -o remount,rw /boot" > /usr/local/bin/remountro
chmod +x /usr/local/bin/remountro

echo "You can now use remountrw and remountro command, have fun !"

echo "Done."

