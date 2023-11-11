#!/bin/bash

set -e

trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
trap 'echo "$0: \"${last_command}\" command failed with exit code $?"' ERR


default=y
[[ -t 0 ]] && { read -t 10 -n 2 -p $'\e[1;32mInstall wirehole? [y/n] (default: '"$default"$')\e[0m\n' resp || resp=$default ; }

response=`echo $resp | sed -r 's/(.*)$/\1=/'`


if [[ $response =~ ^(y|Y)=$ ]]
then
	toilet Installing wirehole

	cd ~/git
	git clone git@github.com:IAmStoxe/wirehole.git
elif [[ $response =~ ^(n|N)=$ ]]
then
	break
else
	echo " What? \"$resp\" is not a correct answer. Try y+Enter."
fi

