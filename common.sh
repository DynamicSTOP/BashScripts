#!/bin/bash

# find all modified in last 30 days and zip it
tar czvf 30days.tgz `find . -mtime -30 -type f`

# list all files in archive
tar --list --verbose --file=30days.tgz

# extract files
tar -xvzf 30days.tgz
