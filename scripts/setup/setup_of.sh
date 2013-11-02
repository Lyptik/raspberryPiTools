#!/bin/sh

# Script for raspberry pi system installation

echo "Creating a ~/sources directory" &&
mkdir -p ~/sources &&
cd ~/sources &&
echo "Fetching openframeworks through git..." &&
git clone https://github.com/openframeworks/openFrameworks &&

echo "Done."

