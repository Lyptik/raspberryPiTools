#!/bin/sh

# Install gphotos2 (to use a canon with the raspberry pi)

# Save current dir
SCRIPT_DIR=$PWD

echo "Installing software dev env..." &&
sudo apt-get update && sudo apt-get upgrade -y --force-yes &&
sudo apt-get install -y --force-yes python &&

echo "Creating a ~/sources directory" &&
mkdir -p ~/sources &&
cd ~/sources &&

echo "Compiling gphotos2" &&
# From repo
#sudo apt-get install libgphoto2-2-dev gphotos2 -y --force-yes &&

[ -d gphoto2-updater ] || git clone https://github.com/gonzalo/gphoto2-updater.git &&
cd gphoto2-updater &&
sudo ./gphoto2-updater.sh &&

# -- OpenCV Installation --
#echo "Compiling opencv..." &&
#sudo apt-get update && sudo apt-get install -y --force-yes libeigen3-dev libgtk2.0-dev &&
#[ -d opencv ] || git clone git://github.com/Itseez/opencv.git &&
#cd opencv &&
#git checkout 2.4.4 &&
#mkdir -p build &&
#cd build &&
#echo "Compiling OpenCV (config -> TBB PYTHON V4L FFMPEG...)"
#cmake -D WITH_TBB=ON -D WITH_OPENNI=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D WITH_FFMPEG=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON .. &&
#make -j4 &&
#sudo make install &&
#cd ~/sources &&

echo "Done."
