#!/bin/bash

# find all modified in last 30 days and zip it
tar czvf 30days.tgz `find . -mtime -30 -type f`

# list all files in archive
tar --list --verbose --file=30days.tgz

# extract files
tar -xvzf 30days.tgz

# get ips connected to nginx
netstat -ntupa | grep nginx | sed  -e 's|\s\{1,\}| |g'| cut -d" " -f5| cut -d":" -f1 | sort|uniq -c
