#!/bin/bash

## get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

# define paths
APPCONFIG_PATH=$MY_PATH/appconfig

arch=`uname -m`

subinstall_params=""
unattended=0
for param in "$@"
do
  echo $param
  if [ $param="--unattended" ]; then
    echo "installing in unattended mode"
    unattended=1
    subinstall_params="--unattended"
  fi
done

# install packages
sudo apt-get -y update

cd $MY_PATH
git submodule update --init --recursive

# essentials
sudo apt-get -y install tig toilet ruby gem silversearcher-ag fzf duf 

# python
sudo apt-get -y install python3-dev python3-setuptools python3-pip

#############################################
# core installation
#############################################

# install TMUX
bash $APPCONFIG_PATH/tmux/install.sh $subinstall_params

# install TMUXINATOR
bash $APPCONFIG_PATH/tmuxinator/install.sh $subinstall_params

# install VIM
bash $APPCONFIG_PATH/vim/install.sh $subinstall_params

# install RANGER
bash $APPCONFIG_PATH/ranger/install.sh $subinstall_params

# install DOCKER
bash $APPCONFIG_PATH/docker/install.sh $subinstall_params

# install MOTD
bash $APPCONFIG_PATH/motd/install.sh $subinstall_params

#############################################
# adding Locale variables to .bashrc
#############################################

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
# link the scripts folder
#############################################

if [ ! -e ~/.scripts ]; then
  ln -sf $MY_PATH/scripts ~/.scripts
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

# sourcing .bashr with added variables
source ~/.bashrc

# deploy configs by Profile manager
./deploy_configs.sh

toilet All Done

echo "Your RPi-linux setup should be ready."
