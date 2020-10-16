## Overview

This repository is intended to store some of the scripts which I write for my own convenience. Currently there are only two, but this will expand over time. As these are simply for convenience, none of these scripts are likely to be extremely complicated.

### sharep.sh

The sharep script is intended as a convenience wrapper around the Python http.server module which allows for the serving of directories as websites. Sharep can be used as a command line utility which will serve a specified file on a specified port, rather than serving a directory. Additionally, if xclip is installed then the IP address of the server will be copied to the clipboard of the user.

### cdr.sh

cdr is a simple recursive version of the cd command line utility. If there is one folder within the current directory which ends in the pathname given to the cdr command, then the terminal will be navigated to this directory. The current version is a proof of concept; it isn't written well, but it does work to a reasonable extent.
