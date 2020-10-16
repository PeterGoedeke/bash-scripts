#!/usr/bin/env bash

path="$HOME/shared"
port=8000

if ! command -v xclip &> /dev/null; then
	echo "This script requires python3 to be installed."
	exit
fi

publicIP=$(dig +short myip.opendns.com @resolver1.opendns.com)
localIP=$(hostname -I | sed 's/ *$//')
copyIP=$publicIP
WGET=0

while getopts ":p:dlw" opt; do
	case ${opt} in
		d ) rm -rf $path
		  ;;
		p ) port=$OPTARG
		  ;;
		l ) copyIP=$localIP
		  ;;
		w ) WGET=1
		  ;;
		: ) echo "This option requires an argument"
		  ;;
		\? ) echo "Usage: cmd [-d] [-p] [-l] SOURCE"
	esac
done
shift $((OPTIND -1))

if [[ $# -eq 0 ]]; then
	echo "Usage: [OPTIONS] SOURCE"
	exit 1;
fi

mkdir -p $path 2> /dev/null

cp "$1" "$path/$(basename "$1")"

cd $path || exit

echo "Server hosted publicly at $publicIP:$port"
echo "Server hosted locally at $localIP:$port" 

if command -v xclip &> /dev/null; then
	echo "$copyIP:$port"
	if [ $WGET == 0 ]; then
		COPY_STR="$copyIP:$port"
	else
		COPY_STR="wget $copyIP:$port/$(basename $1)"
	fi
	echo -n "$COPY_STR" | $(xclip -selection clipboard) &
fi

python3 -m http.server "$port"