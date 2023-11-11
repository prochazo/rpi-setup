#!/bin/bash

## get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# define paths
APPCONFIG_PATH=$MY_PATH/appconfig


# install toilet
sudo apt install toilet

# install vim
sudo apt install vim

# Clone Tom's linux setup package
cd ~/git
git clone https://github.com/klaxalk/linux-setup


# install TMUX
sudo apt-get -y install tmux

# install RANGER


# install DOCKER
bash $APPCONFIG_PATH/docker/install.sh


# Setup locale in bashrc
line='LC_ALL="en_GB.UTF-8"'
num=`cat ~/.bashrc | grep "$line" | wc -l`
if [ "$num" -lt "1" ]; then

	echo "Adding '$line' to your .bashrc"

	# set exports to .bashrc
	echo "
   	$line" >> ~/.bashrc
fi
	 
line='alias ll="ls -alF"'
num=`cat ~/.bashrc | grep "$line" | wc -l`
if [ "$num" -lt "1" ]; then

	echo "Adding '$line' to your .bashrc"

	# set exports to .bashrc
	echo "
   	$line" >> ~/.bashrc
fi
