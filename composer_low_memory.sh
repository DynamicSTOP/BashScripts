#!/bin/bash
# show memory info
df -h
# create 1gb file full of nils
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
# format it as swap. magic
/sbin/mkswap /var/swap.1
# enables as swap
/sbin/swapon /var/swap.1
# once again shows memory
free -m
# composer update. will show memory usage. might need to change count on line 5
./composer update -vvv --profile
# disables swap
/sbin/swapoff /var/swap.1
# removes swap
rm /var/swap.1

# don't forget to make chown
