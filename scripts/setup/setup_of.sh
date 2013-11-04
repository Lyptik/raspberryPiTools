#!/bin/sh

# Script for raspberry pi system installation

echo "Creating a ~/sources directory" &&
mkdir -p ~/sources &&
cd ~/sources &&
echo "Fetching openframeworks through git..." &&
git clone https://github.com/openframeworks/openFrameworks &&
echo "Installing dependencies" &&
cd openFrameworks/scripts/linux/debian_armv6l &&
sudo ./install_dependencies.sh &&
echo "Compiling openFrameworks" &&
make Release -C /home/pi/openFrameworks/libs/openFrameworksCompiled/project &&
echo "Compiling all examples" &&
cd /Users/david/code/openFrameworks/scripts/linux &&
./buildAllRPIExamples.sh &&
echo "Done."
