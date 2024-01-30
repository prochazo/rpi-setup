#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR

# get the path to this script
APP_PATH=`dirname "$0"`
APP_PATH=`( cd "$APP_PATH" && pwd )`

unattended=0
subinstall_params=""
for param in "$@"
do
  echo $param
  if [ $param="--unattended" ]; then
    echo "installing in unattended mode"
    unattended=1
    subinstall_params="--unattended"
  fi
done

default=y
while true; do
  if [[ "$unattended" == "1" ]]
  then
    resp=$default
  else
    [[ -t 0 ]] && { read -t 10 -n 2 -p $'\e[1;32mInstall mode of the day (MOTD)? [y/n] (default: '"$default"$')\e[0m\n' resp || resp=$default ; }
  fi
  response=`echo $resp | sed -r 's/(.*)$/\1=/'`

  if [[ $response =~ ^(y|Y)=$ ]]
  then

    toilet Setting up MOTD

    if [ -f /etc/motd ]; then
      sudo mv /etc/motd /etc/motd.bak
    fi

    if [ -f /etc/update-motd.d/10-uname ]; then
      sudo rm /etc/update-motd.d/10-uname
    fi

    sudo sed -i 's/#PrintLastLog yes/PrintLastLog no/' /etc/ssh/sshd_config
    sudo systemctl restart sshd

    sudo ln -fs $APP_PATH/11-welcome /etc/update-motd.d/
    sudo ln -fs $APP_PATH/15-system /etc/update-motd.d/

    break
  elif [[ $response =~ ^(n|N)=$ ]]
  then
    break
  else
    echo " What? \"$resp\" is not a correct answer. Try y+Enter."
  fi
done
