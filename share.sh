#!/bin/bash

if [[ $# -eq 0 ]]; then
	echo "Usage: <filepath>"
	exit 1;
fi

mkdir -p /home/peter/Documents/shared 2> /dev/null

cp $1 /home/peter/Documents/shared/$(basename $1)

cd /home/peter/Documents/shared

publicIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
localIP=$(hostname -I)
echo "Server hosted publicly at $publicIP:8000"
echo "Server hosted locally at $localIP:8000" 
python3 -m http.server 1> /dev/null
echo $publicIP:8000 | $(xclip -selection clipboard)
