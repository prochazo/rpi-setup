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

# python
sudo apt-get -y install python3-dev python3-setuptools python3-pip

# other stuff
sudo apt-get -y install ruby gem

# Clone Tom's linux setup package
# cd ~/git
# git clone https://github.com/klaxalk/linux-setup
# cd linux setup
# git submodule update --init --recursive --recommend-shallow

# install TMUX
sudo apt-get -y install tmux

# install RANGER
bash $APPCONFIG_PATH/ranger/install.sh $subinstall_params

# install DOCKER
bash $APPCONFIG_PATH/docker/install.sh

# install TMUXINATOR
bash $APPCONFIG_PATH/tmuxinator/install.sh $subinstall_params

# Setup locale in bashrc
line="export LC_ALL='en_GB.UTF-8'"
num=`cat ~/.bashrc | grep "$line" | wc -l`
if [ "$num" -lt "1" ]; then

	echo "Adding '$line' to your .bashrc"

	# set exports to .bashrc
	echo "
   	$line" >> ~/.bashrc
fi
	 
#############################################
# adding GIT_PATH variable to .bashrc
#############################################

# add variable for path to the git repository
num=`cat ~/.bashrc | grep "GIT_PATH" | wc -l`
if [ "$num" -lt "1" ]; then

  TEMP=`( cd "$MY_PATH/../" && pwd )`

  echo "Adding GIT_PATH variable to .bashrc"
  # set bashrc
  echo "
# path to the git root
export GIT_PATH=$TEMP" >> ~/.bashrc
fi

#############################################
# add PROFILES variables
#############################################

num=`cat ~/.bashrc | grep "PROFILES" | wc -l`
if [ "$num" -lt "1" ]; then

  echo "Adding epigen rules to .bashrc"
  echo '
# list (space-separated) of profile names for customizing configs
export PROFILES="COLORSCHEME_DARK"' >> ~/.bashrc

fi

#############################################
# add sourcing of dotbashrd to .bashrc
#############################################
num=`cat ~/.bashrc | grep "dotbashrc" | wc -l`
if [ "$num" -lt "1" ]; then

  echo "Adding source to .bashrc"
  # set bashrc
  echo "
# sourcing RPi's linux setup
source $APPCONFIG_PATH/bash/dotbashrc" >> ~/.bashrc

fi

# deploy configs by Profile manager
./deploy_configs.sh

toilet All Done

echo "Your RPi-linux setup should be ready."
