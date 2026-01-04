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
    [[ -t 0 ]] && { read -t 10 -n 2 -p $'\e[1;32mInstall vim? [y/n] (default: '"$default"$')\e[0m\n' resp || resp=$default ; }
  fi
  response=`echo $resp | sed -r 's/(.*)$/\1=/'`

  if [[ $response =~ ^(y|Y)=$ ]]
  then

    toilet Setting up vim

    sudo apt-get -y remove vim-* || echo ""

    sudo apt-get -y install libncurses5-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python3-dev clang-format

    # compile vim from sources
    cd $APP_PATH/../../submodules/vim
    ./configure --with-features=huge \
      --enable-multibyte \
      --enable-python3interp=yes \
      --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
      --enable-perlinterp=yes \
      --enable-luainterp=yes \
      --enable-gui=no \
      --enable-cscope --prefix=/usr

      ## add for python2
      # --enable-pythoninterp=yes \
      # --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \

      ## add for python3
      # --enable-python3interp=yes \
      # --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \

      cd src
      make
      cd ../
      make VIMRUNTIMEDIR=/usr/share/vim/vim81
      sudo make install

    # set vim as a default git mergetool
    git config --global merge.tool vimdiff

    # symlink vim settings
    rm -rf ~/.vim
    ln -fs $APP_PATH/dotvim ~/.vim

    # check if minimalist Vim plugin manager is included
    cd $APP_PATH/../../submodules
    if [ ! -d vim-plug ]; then
      git submodule add https://github.com/junegunn/vim-plug.git
    fi

    # updated new plugins and clean old plugins
    /usr/bin/vim -E -c "let g:user_mode=1" -c "so $APP_PATH/dotvimrc" -c "PlugInstall" -c "wqa" || echo "It normally returns >0"

    # install nodejs requreid coc.nvim
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs

    break
  elif [[ $response =~ ^(n|N)=$ ]]
  then
    break
  else
    echo " What? \"$resp\" is not a correct answer. Try y+Enter."
  fi
done
